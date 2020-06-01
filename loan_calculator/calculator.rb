def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  integer(number) || float(number)
end

def integer?(number)
  Integer(number) rescue false
end

def float?(number)
  Float(number) rescue false
end

def print_operator(operator)
  case operator
  when '1'
    '+'
  when '2'
    '-'
  when '3'
    '*'
  when '4'
    '/'
  end
end

prompt("Welcome to the Calculator.")

name = ''
loop do
  prompt("What's your name?")
  name = Kernel.gets().chomp()
  if name.empty?()
    prompt("Please enter a valid name.")
  else
    break
  end
end

loop do
  number1 = ''
  loop do
    prompt("#{name}, what's the first number?")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("Hmm... That doesn't look like a valid number.")
    end
  end

  number2 = ''
  loop do
    prompt("What's the second number?")
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt("Hmm... That doesn't look like a valid number.")
    end
  end

  operator_prompt = <<-MSG
   What calculation would you like to perform?
   1) add
   2) subtract
   3) multiply
   4) divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("That's not a valid choice. Enter 1 2 3 or 4:")
    end
  end

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("#{number1} #{print_operator(operator)} #{number2} = #{result}")

  prompt("Do you want to perform another calculation? (y to caculate again)")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using Calculator. Goodbye!")
