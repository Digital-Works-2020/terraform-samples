#Sensitive text
resource "random_bytes" "random_digits_or_text"{
  length =  64
}

#Non Sensitive text
resource "random_id" "random_id_resource"{
 byte_length = 8
}

#Random Integer Generation
resource "random_integer" "random_integer_gen"{
 min = 100
 max = 5000
}

#Random Password - Length >= (Min Lower + Min Upper + Min Speical + Min Number
resource "random_password" "random_password_generation"{
 #Only Mandate - Length
 length           = 8
 override_special = "!#$%&*()-_=+[]{}<>:?"
 min_lower        = 0
 min_upper        = 0
 min_special      = 0
 min_numeric      = 0
}

#Random Pet
resource "random_pet" "random_pet"{
 #No Mandate Arguments. Length is number of words
 prefix    = "Mrs."
 length    = 2
 separator = " "
}

#Random Shuffle. Only Shuffle List Mandate
resource "random_shuffle" "random_shuffler"{
 input        = ["apple","Kiwi","Grape","Guava"]
 result_count = 2
}

#Random String. Similar to Password
resource "random_string" "random_string_gen"{
  length           = 10
  special          = true
  override_special = "/@£$"
}

#Random Unique Id. No Mandate Args
resource "random_uuid" "random_uuid_gen"{
}
