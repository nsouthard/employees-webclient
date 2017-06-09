class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthday
  def initialize(hash_options)
    @id = hash_options["id"]
    @first_name = hash_options["first_name"]
    @last_name = hash_options["last_name"]
    @email = hash_options["email"]
    @birthday = Date.parse(hash_options["birthday"]) if hash_options["birthday"]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friendly_birthday
    birthday ? birthday.strftime('%b %d, %Y') : "N/A" #ternary (conditional) operator
    # if birthday
    #   birthday.strftime('%b %d, %Y')
    # else
    #   "N/A"
  end

  def self.find(id)
    Employee.new(Unirest.get("#{ENV["API_HOST"]}/api/v2/employees/#{ id }.json").body)
  end

  def self.all
    @employee = []
    employee_hash = Unirest.get("#{ENV["API_HOST"]}/api/v2/employees.json").body

    employee_hash.each do |employee_hash|
      @employee << Employee.new(employee_hash)
    end
    employees
  end

  def self.create(employee_params)
    response = Unirest.post(
                                    "#{ENV["API_HOST"]}/api/v1/employees.json",
                                    headers: {
                                              "Accept" => "application/json"
                                              },
                                    parameters: employee_params
                                    ).body
    Employee.new(response)
  end

end