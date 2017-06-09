class EmployeesController < ApplicationController

  def index
    # @employees = Unirest.get("#{ENV["API_HOST"]}/api/v2/employees.json").body

    @employee = Employee.all
  end

  def new

  end

  def create
    employee = Unirest.post(
                                "#{ENV["API_HOST"]}/api/v1/employees.json",
                                headers: {
                                          "Accept" => "application/json"
                                          },
                                parameters: {
                                         first_name: params[:first_name],
                                         last_name: params[:last_name],
                                         email: params[:email]
                                        }
                                ).body

    employee = Employee.create(
                              first_name: params[:first_name],
                              last_name: params[:last_name],
                              email: params[:email]
                              )
                                                     
    redirect_to "/employees/#{employee["id"]}"
  end

  def show
    # @employee = Employee.new(Unirest.get("#{ENV["API_HOST"]}/api/v2/employees/#{params[:id]}.json").body)
    @employee = Employee.find(params[:id]) #replaces the code above since we created .self method in model
  end

  def edit
      # @employee = Unirest.get("#{ENV["API_HOST"]}/api/v1/employees/#{params[:id]}.json").body
      @employee = Employee.find(params[:id]) #replaces the code above since we created .self method in model
    end

    def update
      @employee = Employee.find(params[:id])
      @employee.update(
                       first_name: params[:first_name],
                       last_name: params[:last_name],
                       email: params[:email] 
                        )
      employee = Unirest.patch(
                              "#{ENV["API_HOST"]}/api/v1/employees/#{params["id"]}.json",
                              headers: {
                                        "Accept" => "application/json"
                                        },
                              parameters: {
                                       first_name: params[:first_name],
                                       last_name: params[:last_name],
                                       email: params[:email]
                                      }
                              ).body
      redirect_to "/employees/#{employee["id"]}"
    end

    def destroy
      Unirest.delete(
                     "#{ENV["API_HOST"]}/api/v1/employees/#{params["id"]}.json",
                     headers: {
                               "Accept" => "application/json"
                               }
                     ).body
      redirect_to "/employees"
    end

end

