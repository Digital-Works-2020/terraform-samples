#Sample Pet Name - Using Length & Prefix as variables
resource "random_pet" sample_pet{
  length = var.pet_words_count
  prefix = tolist(var.salutation)[0]
}

#Sample Fruit - Generate using list shuffler
resource "random_shuffle" fruit{
  input        = var.fruits
  result_count = 1
}

#Sample file - Generate file name & content using variables
resource "local_file" file_res{
  filename = var.file_params["filename"]
  content  = var.file_params["content"]
}
