class Dog

  attr_accessor :name, :breed, :id

  def initialize(name, breed, id = nil)
    @breed = breed
    @name = name
    @id = id
  end


end
