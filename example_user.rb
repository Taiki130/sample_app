class User
    attr_accessor :first_name, :last_name, :email
  
    def initialize(attributes = {})
      @first_name = attributes[:first_name]
      @last_name = attributes[:last_name]
      @email = attributes[:email]
    end

    def full_name
        "#{@last_name}　#{@first_name}"
    end
  
    def formatted_email
      "#{@full_name} <#{@email}>"
    end

    def alphabetical_name
        full_name.split(" ").join(", ")
    end
  end

user = User.new(first_name: "Michael", last_name:"Hartl", email: "mhartl@example.com")
p user.full_name.split
p user.alphabetical_name.split(', ').reverse