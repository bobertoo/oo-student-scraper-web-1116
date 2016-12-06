class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student| Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash[:twitter] ? @twitter = attributes_hash[:twitter] : nil
    attributes_hash[:linkedin] ? @linkedin = attributes_hash[:linkedin] : nil
    attributes_hash[:github] ? @github = attributes_hash[:github] : nil
    attributes_hash[:blog] ? @blog = attributes_hash[:blog] : nil
    attributes_hash[:profile_quote] ? @profile_quote = attributes_hash[:profile_quote] : nil
    attributes_hash[:bio] ? @bio = attributes_hash[:bio] : nil
    attributes_hash[:profile_url] ? @profile_url = attributes_hash[:profile_url] : nil
  end

  def self.all
    @@all
  end
end
