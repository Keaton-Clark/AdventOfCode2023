let g:sum = 0
for line in readfile("input.txt")
	let ct = 0
	let line = split(substitute(line, "Card .*: ", "", ""), " | ")
	let line[0] = split(line[0])
	let line[1] = split(line[1])
	for val in line[0]
		if index(line[1], val) >= 0
			if ct == 0
				let ct = 1
			else
				let ct = ct * 2
			endif
		endif
	endfor
	let g:sum = ct + g:sum
endfor
echo sum
