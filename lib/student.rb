require 'pry'

class Student


  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students (id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL

    DB[:conn].execute(sql)

  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)

  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    id = <<-SQL
    SELECT id FROM students WHERE (name = ?)
    SQL


    @id = DB[:conn].execute(id, self.name)[0][0]




    # @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]


  end

  def self.create(student_info)
    student = Student.new(student_info[:name], student_info[:grade])
    student.save
    student
  end






  
end


