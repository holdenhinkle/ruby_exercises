require 'yaml'

MESSAGES = YAML.load_file('loan_calculator_messages.yml')

LANGUAGE = 'en'

MONTHS_IN_YEAR = 12

LOAN_TYPE = %w(1 car 2 home)

def clear_screen
  system('clear')
end

def head_msg(message, lang=LANGUAGE)
  Kernel.puts(MESSAGES[lang][message].to_s)
end

def norm_msg(message, lang=LANGUAGE)
  Kernel.puts(MESSAGES[lang][message].to_s)
end

def head_txt(message)
  Kernel.puts("=> #{message}")
end

def norm_txt(message)
  Kernel.puts(message.to_s)
end

def sanitize_loan_type(loan_choice)
  %w(1 car).include?(loan_choice) ? 'Car' : 'Home'
end

def loan_type
  clear_screen
  head_msg('loan_type')
  loop do
    norm_msg('loan_type_car')
    norm_msg('loan_type_home')
    loan_choice = Kernel.gets().chomp().downcase()
    return sanitize_loan_type(loan_choice) if LOAN_TYPE.include?(loan_choice)
    head_msg('loan_type_valid')
  end
end

def loan_amt
  clear_screen
  head_msg('loan_amt')
  loop do
    amount = Kernel.gets().chomp().to_f()
    return amount if valid_number?(amount)
    head_msg('loan_amt_valid')
  end
end

def loan_term(type)
  clear_screen
  case type
  when 'Car'
    car_loan_term
  when 'Home'
    home_loan_term
  end
end

def car_loan_term
  head_msg('car_loan_term')
  loop do
    norm_msg('car_loan_term_2_years')
    norm_msg('car_loan_term_3_years')
    norm_msg('car_loan_term_4_years')
    norm_msg('car_loan_term_5_years')
    term = Kernel.gets().chomp()
    return term.to_i if %w(2 3 4 5).include?(term)
    head_msg('car_loan_term_valid')
  end
end

def home_loan_term
  head_msg('home_loan_term')
  loop do
    norm_msg('home_loan_term_15_years')
    norm_msg('home_loan_term_20_years')
    norm_msg('home_loan_term_25_years')
    norm_msg('home_loan_term_30_years')
    term = Kernel.gets().chomp()
    return term.to_i if %w(15 20 25 30).include?(term)
    head_msg('home_loan_valid')
  end
end

def interest_rate
  clear_screen
  head_msg('interest_rate')
  loop do
    rate = Kernel.gets().chomp().to_f()
    return rate if valid_number?(rate)
    head_msg('interest_rate_valid')
  end
end

def valid_number?(input)
  (integer?(input) || float?(input)) && input >= 0
end

def integer?(input)
  input.is_a? Integer
end

def float?(input)
  input.is_a? Float
end

def yes?(input)
  %w(y yes).include?(input.downcase)
end

def no?(input)
  %w(n no).include?(input.downcase)
end

def format_f(num)
  add_commas_to_f(add_two_decimal_places_to_f(num))
end

def add_two_decimal_places_to_f(num)
  format('%02.2f', num)
end

def add_commas_to_f(num)
  whole, decimal = num.to_s.split(".")
  whole_with_commas = add_commas_to_s(whole)
  [whole_with_commas, decimal].compact.join(".")
end

def add_commas_to_s(num)
  num.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
end

def display_loan(loan)
  clear_screen
  display_loan_heading
  display_loan_details(loan)
end

def display_loan_heading
  head_msg('loan_details')
end

def display_loan_details(loan)
  norm_txt("Type: #{loan[:type]} loan")
  norm_txt("Term: #{loan[:term]} years")
  norm_txt("Interest rate: #{format_f(loan[:rate])}%")
  norm_txt("Amount: $#{format_f(loan[:amount])}")
  norm_txt("Total amount to be paid: $#{calc_amt_to_be_paid(loan)}")
  norm_txt("Cost of loan: $#{calc_cost_of_loan(loan)}")
  norm_txt("Monthly payment: $#{format_f(loan[:payment])}")
end

def calc_amt_to_be_paid(loan)
  format_f(loan[:payment] * loan[:term] * MONTHS_IN_YEAR)
end

def calc_cost_of_loan(loan)
  format_f((loan[:payment] * loan[:term] * MONTHS_IN_YEAR) - loan[:amount])
end

def calc_monthly_payment(loan)
  rate = calc_monthly_interest_rate_as_decimal(loan)
  if rate == 0
    return calc_monthly_payment_zero_interest(loan)
  else
    calc_monthly_payment_with_interest(rate, loan)
  end
end

def calc_monthly_interest_rate_as_decimal(loan)
  loan[:rate] / 100 / MONTHS_IN_YEAR
end

def calc_monthly_payment_zero_interest(loan)
  loan[:amount] / loan[:term_in_mths]
end

def calc_monthly_payment_with_interest(rate, loan)
  (loan[:amount] * (rate * (1 + rate)**loan[:term_in_mths]) /
  ((1 + rate)**loan[:term_in_mths] - 1))
end

def display_amort_schedule?
  head_msg('amortization_see_schedule')
  loop do
    norm_msg('amortization_see_schedule_prompt')
    display_amort = Kernel.gets().chomp()
    return true if yes?(display_amort)
    return false if no?(display_amort)
    norm_msg('amortization_see_schedule_valid')
  end
end

def ask_for_amort_display_period
  clear_screen
  head_msg('amortization_period_interval_prompt')
  loop do
    norm_msg('amortization_period_interval_prompt_m')
    norm_msg('amortization_period_interval_prompt_q')
    norm_msg('amortization_period_interval_prompt_y')
    period = Kernel.gets().chomp()
    return add_amort_view_period(period) if %w(m q y).include?(period)
    head_msg('amortization_period_interval_valid')
  end
end

def add_amort_view_period(period)
  case period
  when 'm'
    { label: 'Month', frequency: 1 }
  when 'q'
    { label: 'Quarter', frequency: 3 }
  else
    { label: 'Year', frequency: 12 }
  end
end

def display_amort_schedule(view_period, loan)
  clear_screen
  head_msg('amortization_display_schedule')
  initialize_amort_values(view_period, loan)
end

def initialize_amort_values(view_period, loan)
  loan[:balance] = loan[:amount]
  loan[:total_interest] = 0
  loan[:total_principle] = 0
  loan[:total_paid] = 0
  loan[:month] = 1
  display_amort_by_period(view_period, loan)
end

def display_amort_by_period(view_period, loan)
  loan[:term_in_mths].times do
    update_amort_loan_values(loan)
    if display_amort_period?(view_period, loan)
      display_amort_heading(view_period, loan)
      display_amort_details_part_1(loan)
      display_amort_details_part_2(loan)
    end
    loan[:month] += 1
  end
end

def display_amort_period?(view_period, loan)
  if view_period[:label] == 'Month'
    true
  elsif %w(Quarter Year).include?(view_period[:label])
    loan[:month] % view_period[:frequency] == 1 ||
      loan[:month] == loan[:term_in_mths]
  end
end

def display_amort_heading(view_period, loan)
  if final_payment?(loan)
    display_final_payment_heading(loan)
  elsif qtr_or_year_view_period?(view_period)
    display_qtr_or_year_view_period(view_period, loan)
  else
    display_mo_view_period(loan)
  end
end

def final_payment?(loan)
  loan[:month] == loan[:term_in_mths]
end

def display_final_payment_heading(loan)
  head_txt("FINAL PAYMENT") if loan[:month] == loan[:term_in_mths]
  head_txt("Month: #{loan[:month]}")
end

def qtr_or_year_view_period?(view_period)
  %w(Quarter Year).include?(view_period[:label])
end

def display_qtr_or_year_view_period(view_period, loan)
  head_txt("#{view_period[:label].upcase} #{(loan[:month] /
                 view_period[:frequency] + 1)}, Month #{loan[:month]}")
end

def display_mo_view_period(loan)
  head_txt("Month: #{loan[:month]}")
end

def display_amort_details_part_1(loan)
  norm_txt("Payment: $#{format_f(loan[:payment])}")
  norm_txt("Payment Towards Principle: $#{format_f(loan[:towards_principle])}")
  norm_txt("Payment Towards Interest: $#{format_f(loan[:towards_interest])}")
end

def display_amort_details_part_2(loan)
  norm_txt("Total Paid: $#{format_f(loan[:total_paid])}")
  norm_txt("Total Principle: $#{format_f(loan[:total_principle])}")
  norm_txt("Total Interest: $#{format_f(loan[:total_interest])}")
  norm_txt("Balance: $#{format_f(loan[:balance])}")
  norm_txt("")
end

def update_amort_loan_values(loan)
  loan[:towards_interest] = update_payment_towards_interest(loan)
  loan[:towards_principle] = update_payment_towards_principle(loan)
  loan[:total_interest] = update_total_interest(loan)
  loan[:total_principle] = update_total_principle(loan)
  loan[:total_paid] = update_total_paid(loan)
  loan[:balance] = update_balance(loan)
end

def update_payment_towards_interest(loan)
  if loan[:rate] == 0
    0
  else
    loan[:balance] * calc_monthly_interest_rate_as_decimal(loan)
  end
end

def update_payment_towards_principle(loan)
  loan[:payment] - loan[:towards_interest]
end

def update_total_interest(loan)
  loan[:total_interest] + loan[:towards_interest]
end

def update_total_principle(loan)
  loan[:total_principle] + loan[:towards_principle]
end

def update_total_paid(loan)
  loan[:total_paid] + loan[:payment]
end

def update_balance(loan)
  loan[:balance] - loan[:towards_principle]
end

def calc_another_loan?
  head_msg('calc_another_loan_prompt')
  norm_msg('calc_another_loan_prompt_y_n')
  loop do
    answer = gets().chomp()
    return true if yes?(answer)
    return false if no?(answer)
    norm_msg('calc_another_loan_prompt_valid')
  end
end

loop do
  loan = {}
  loan[:type] = loan_type
  loan[:amount] = loan_amt
  loan[:term] = loan_term(loan[:type])
  loan[:term_in_mths] = loan[:term] * MONTHS_IN_YEAR
  loan[:rate] = interest_rate
  loan[:payment] = calc_monthly_payment(loan)
  display_loan(loan)
  if display_amort_schedule?
    display_amort_schedule(ask_for_amort_display_period, loan)
  end
  break unless calc_another_loan?
end
