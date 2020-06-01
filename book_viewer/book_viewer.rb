require "pry"
require "tilt/erubis"
require "sinatra"
require "sinatra/reloader" if development?

before do
  @toc = File.readlines('data/toc.txt')
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").map.with_index do |paragraph, index|
      "<p id=\"#{index + 1}\">#{paragraph}</p>"
    end.join
  end

  def bold(query, text)
    text.gsub(query, "<strong>#{query}</strong>")
  end
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  erb :home
end

get "/chapter/:number" do
  number = params["number"].to_i
  redirect "/" unless (1..@toc.size).cover?(number)
  @title = "Chapter #{number}: #{@toc[number - 1]}"
  @chapter = File.read("data/chp#{number}.txt")
  erb :chapter
end

get "/search" do
  @results = chapters_matching(params[:query])
  erb :search
end

not_found do
  redirect "/"
end

# Calls the block for each chapter, passing that chapter's number, name, and
# contents.
def each_chapter
  @toc.each_with_index do |title, index|
    chapter_number = index + 1
    contents = in_paragraphs(File.read("data/chp#{chapter_number}.txt"))
               .split(/(?<=\/p>)/)
    contents.each_with_index do |paragraph, id|
      id += 1
      yield chapter_number, title, paragraph, id
    end
  end
end

# This method returns an Array of Hashes representing chapters that match the
# specified query. Each Hash contain values for its :name and :number keys.
def chapters_matching(query)
  results = []
  return results if !query || query.empty?
  each_chapter do |chapter_number, title, paragraph, id|
    if paragraph.include?(query)
      results << { chapter_number: chapter_number, title: title, 
                   paragraph: bold(query, paragraph), id: id }
    end
  end
  results
end
