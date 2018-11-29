def assert message, &block
  begin
    if (block.call)
      puts "PASSED: #{message}"
    else
      puts "FAILED: #{message}"
    end
  rescue => e
    puts "FAILED: #{message}; exception: '#{e}'"
  end
end
