class CleanSlate
  instance_methods.each { |m| undef_method m unless m =~ /^__/ }
end