# Local Provider - File Resource Creation with 700 Permission
resource "local_sensitive_file" "simple_file" {
  filename        =  "/root/Simple_File.txt"
  content         =  "This is an Sample file"
  file_permission =  "0700"
}
