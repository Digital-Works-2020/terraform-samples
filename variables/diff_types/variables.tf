
#Type is optional and used to enforce data type constraints
variable image_id{
   type = string
   default = "ami-0c55b159cbfafe1f0"
}

variable pet_words_count{
   type = number
   default = 3
}

variable human_or_bot{
   type = bool
   default = false
}

variable fruits{
   type = list(string)
   default = ["Apple", "Orange", "Kiwi"]
}

#Set - List without duplicates
variable salutation{
   type = set(string)
   default = ["Mr", "Mrs"]
}


variable file_params{
  type = map(string)
  default  = {
      filename = "/root/pets.txt"
      content  = "Pets are Awesome!!"
  }
}

variable cat{
  type =  object({
     name = string
     age = number
     food = list(string)
  })
  default  = {
     name = "Tom"
     age = 21
     food = ["Fish","Cheese"]
  }
}

#Heterogenous List
variable tuple{
   type = tuple([string,number])
   default = ["Jerry",21]
}
