#Gets Current Time
resource "time_static" "created_time" {
}

#Reference above time resource and create content for an sample file
resource local_file sample_file{
   filename = "/root/file.txt"
   content  = "File is created at ${time_static.created_time.id}"
}
