require 'pry'

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(input)
  integer?(input) || float?(input)
end

def integer?(input)
  Integer(input) rescue false
end

def float?(input)
  Float(input) rescue false
end

def get_loan_data(message)
  input = nil
  loop do
    prompt(message)
    input = Kernel.gets().chomp()
    return input if valid_number?(input)
    prompt("That's not a valid number. Try again:")
  end
end

amount = get_loan_data("Loan amount:").to_i()

apr_annual = get_loan_data("Annual Percentage Rate (APR)").to_f() / 100

duration = get_loan_data("Loan duration in years:").to_i()

duration_in_months = duration * 12

apr_month = apr_annual / 12

monthly_payment = amount * (apr_month / (1 - (1 + apr_month)**(-duration_in_months)))

prompt("Your monthly payment is: $#{format('%02.2f', monthly_payment)}")
