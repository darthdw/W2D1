class Employee

  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary)
    @name, @title, @salary = name, title, salary
  end

  def bonus(multiplier)
    @salary * multiplier
  end

  def add_boss(boss)
    @boss = boss
    @boss.add_subordinate(self)
  end

end

class Manager < Employee

  attr_reader :subordinates

  def initialize(name, title, salary)
    super
    @subordinates = []
  end

  def bonus(multiplier)
    calculate_salary * multiplier
  end

  def calculate_salary
    sum = 0
    @subordinates.each do |subordinate|
      sum += subordinate.salary
      sum += subordinate.calculate_salary if subordinate.is_a?(Manager)
    end
    sum
  end

  def add_subordinate(arg)
    @subordinates << arg
  end

end
