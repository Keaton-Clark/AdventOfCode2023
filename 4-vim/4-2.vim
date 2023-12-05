let g:games = []
for line in readfile("input.txt")
	let ct = 0
	let line = split(substitute(line, "Card .*: ", "", ""), " | ")
	let line[0] = split(line[0])
	let line[1] = split(line[1])
	for val in line[0]
		if index(line[1], val) >= 0
			let ct = ct + 1
		endif
	endfor
	let g:games = add(g:games, ct)
endfor
let idx = len(g:games) - 1
while idx >= 0
	let i = 0
	let won = g:games[idx]
	while i < won
		let i = i + 1
		let g:games[idx] = g:games[idx] + g:games[idx + i]
	endwhile
	let idx = idx - 1
endwhile
let sum = len(g:games)
for i in g:games
	let sum = sum + i
endfor
echo sum
