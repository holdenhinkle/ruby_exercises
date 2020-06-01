ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "fileutils"

require_relative "../cms"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def session
    last_request.env["rack.session"]
  end

  def admin_session
    { "rack.session" => { username: "admin" } }
  end

  def setup
    FileUtils.mkdir_p(data_path)
  end

  def teardown
    FileUtils.rm_rf(data_path)
  end

  def create_document(name, content = "")
    File.open(File.join(data_path, name), "w") do |file|
      file.write(content)
    end
  end

  def test_index
    create_document "about.md"
    create_document "changes.txt"

    get "/"

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]

    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
  end

  def test_about_txt_route
    content = "This is the about.txt page."
    create_document "about.txt", content

    get '/about.txt'

    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]

    assert_equal content, last_response.body
  end

  def test_about_md_route
    content = "This is the about.md page."
    create_document "about.md", content

    get '/about.md'

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, content
  end

  def test_history_txt_route
    content = "This is the history.txt page."
    create_document "history.txt", content

    get '/history.txt'

    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, content
  end

  def test_changes_txt_route
    content = "This is the changes.txt page."
    create_document "changes.txt", content

    get '/changes.txt'

    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_equal content, last_response.body
  end

  def test_invalid_file_route
    get '/invalid_file.txt'
    assert_equal 302, last_response.status
    assert_equal "", last_response.body

    get last_response["Location"]
    assert_equal 200, last_response.status
    assert_includes last_response.body, "invalid_file.txt does not exist"

    get '/'
    refute session[:message]
  end

  def test_edit_page
    content = "This is the about.md page."
    create_document "about.md", content

    get '/edit/about.md'
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "Edit the content"
  end

  def test_text_edit_post_response
    content = "This is the changes.txt page."
    create_document "changes.txt", content

    post "/edit/changes.txt", content: "new content"

    assert_equal 302, last_response.status

    get last_response["Location"]

    assert_includes last_response.body, "changes.txt has been updated"

    get "/changes.txt"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "new content"
  end

  def test_view_new_document_form
    get "/new"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_create_new_document
    post "/create", filename: "test.txt"
    assert_equal 302, last_response.status

    get last_response["Location"]
    assert_includes last_response.body, "test.txt was created"

    get "/"
    assert_includes last_response.body, "test.txt"
  end

  def test_create_new_document_without_filename_and_extension
    post "/create", filename: ""
    assert_equal 422, last_response.status
    assert_includes last_response.body, "A name and extension is required."
  end

  def test_create_new_document_without_filename
    post "/create", filename: ".txt"
    assert_equal 422, last_response.status
    assert_includes last_response.body, "A file name is also required."
  end

  def test_create_new_document_without_extension
    post "/create", filename: "hello"
    assert_equal 422, last_response.status
    assert_includes last_response.body, "An file extension is also required."
  end

  def test_delete_file
    content = "Page content."
    create_document "temp.txt", content

    post "/delete/temp.txt"
    assert_equal 302, last_response.status

    get last_response["Location"]
    assert_includes last_response.body, "temp.txt was deleted."

    get "/"
    refute_includes last_response.body, "temp.txt"
  end

  def test_sign_page
    get "/users/signin"
    assert_equal 200, last_response.status
    assert_includes last_response.body, ">Username:</label>"
  end

  def test_index_page_user_is_signed_in
    post "/users/signin", username: "admin", password: "secret"
    assert_equal 302, last_response.status

    get last_response["Location"]
    assert_equal 200, last_response.status
    assert_includes last_response.body, ">Signed in as "
    assert_includes last_response.body, ">Sign Out</button>"
  end

  def test_signin_with_bad_credentials
    post "/users/signin", username: "guest", password: "shhhh"
    assert_equal 422, last_response.status
    assert_includes last_response.body, "Invalid credentials"
  end

  def test_index_page_user_is_signed_out
    get "/"
    assert_equal 200, last_response.status
    assert_includes last_response.body, ">Sign In</a>"
  end

  def test_signout
    post "/users/signin", username: "admin", password: "secret"
    get last_response["Location"]
    assert_includes last_response.body, "Welcome"

    post "/users/signout"
    get last_response["Location"]

    assert_includes last_response.body, "You have been signed out"
    assert_includes last_response.body, "Sign In"
  end
end
