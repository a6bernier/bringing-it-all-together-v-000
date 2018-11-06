class Dog

  attr_accessor :name, :breed, :id

  def initialize(hash)
    @name = hash[:name]
    @breed = hash[:breed]
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
      SQL
      DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE dogs
    SQL
    DB[:conn].execute(sql)
  end

  def save
    if self.id == nil
      sql = <<-SQL
        INSERT INTO dogs (name, breed) VALUES (?,?)
      SQL

      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    else
      self.update
          end
    self
  end

  def self.create(hash)
    new_dog = self.new(hash)
    new_dog.save
  end

  def self.find_by_id
    if self.id == nil
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        Values (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.breed)
      @id = BD[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    else
      self.update
    end
    self
  end

  def update
   sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
   DB[:conn].execute(sql, self.name, self.breed, self.id)
  end 


end
