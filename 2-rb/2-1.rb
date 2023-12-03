total = 0
green_ct = 13
red_ct = 12
blue_ct = 14
File.foreach('2.txt') {|line| 
  line = line.split(':')
  gameno = line[0].scan(/\d/).join('').to_i
  possible = true
  line[1].split(';').each {|set|
    set.split(',').each {|color|
      color = color.split
      if color[1].eql? 'blue'
        if color[0].to_i > blue_ct
          possible = false
        end
      end
      if color[1].eql? 'red'
        if color[0].to_i > red_ct
          possible = false
        end
      end
      if color[1].eql? 'green'
        if color[0].to_i > green_ct
          possible = false
        end
      end
    }
  }
  if possible
    total += gameno
  end
}
puts total
