#Create a sample file
resource local_file sample_file{
 filename  = "/root/file.txt"
 content   = "Output Variables are useful"
}

#Display the content of created sample file as output
output file_content{
 value       = local_file.sample_file.content
 description = "This is the value of content in created file"
}
