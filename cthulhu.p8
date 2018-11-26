pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--variables
--cursor sprite
pc={}
pc.x=63
pc.y=63
pc.sprite=1
--hero sprite
hero={}
hero.x=100
hero.y=25
hero.sprite=16
hero.life=5
hero.lifex=0
hero.lifey=0
hero.attack=2
hero.attackx=0
hero.attacky=8
hero.defense=2
hero.defensex=0
hero.defensey=16
--dialog box sprites
dbox={}
dbox.x0=12
dbox.y0=72
dbox.x1=120
dbox.y1=80
--menu cursor sprite
menusel={}
menusel.x=12
menusel.y=72
menusel.sprite=22
--reino sprites
rei={}
rei.sp1x=96
rei.sp1y=16
rei.sp2x=104
rei.sp2y=16
rei.sp3x=96
rei.sp3y=24
rei.sp4x=104
rei.sp4y=24
rei.firesp1=28
rei.firesp2=26
rei.frame=0
rei.framemax=1
rei.ticks=0
rei.ticksmax=5
--vila sprites
vil={}
vil.sp1x=32
vil.sp1y=64
vil.sp2x=40
vil.sp2y=64
vil.firesp=36
vil.frame=0
vil.framemax=1
vil.ticks=0
vil.ticksmax=5
--tenda sprites
ten={}
ten.sp1x=8
ten.sp1y=104
ten.sp2x=8
ten.sp2y=112
ten.sp3x=16
ten.sp3y=112
ten.firesp=38
ten.frame=0
ten.framemax=1
ten.ticks=0
ten.ticksmax=5
--cthulhu sprites
cth={}
cth.sp1x=0
cth.sp1y=0
cth.sp2x=0
cth.sp2y=0
cth.sp3x=0
cth.sp3y=0
cth.sp4x=0
cth.sp4y=0
cth.life=10
cth.attack=4
cth.defense=4
cth.lifex=120
cth.lifey=0
--hero fighter
herofight={}
herofight.sp1x=80
herofight.sp1y=76
herofight.sp2x=88
herofight.sp2y=76
herofight.sp3x=80
herofight.sp3y=84
herofight.sp4x=88
herofight.sp4y=84
--fire animation
fireani={}
fireani.sp=77
fireani.ticks=0
fireani.ticksmax=5
fireani.frame=0
fireani.framemax=2
--lightning animatioin
lghani={}
lghani.sp1=96
lghani.sp2=112
lghani.ticks=0
lghani.ticksmax=12
lghani.frame=0
lghani.framemax=1
--strings
menutext={"reino","vila","tendas","cancelar"}
menucth={"lutar","cancelar"}
menucombat={"atacar","defender","cultuar cthulhu"}
intro={"a hora sombria se","aproxima. voce esta","preparado?"}
intro2={"va para as cidades para","se fortalecer"}
intro3={"cthulhu esta voltando!","qual sera sua escolha?"}
intro4={"seu heroi aguarda no","reino"}
reino="reino"
vila="vila"
tenda="tendas"
gamestatus="inicio"
combatstatus="combate"
--combate
combattext={"atacar","defender","converter-se"}
--booleans
dl=true
optmenu=false
burnrei=false
burnvil=false
burnten=false
play=false
cthrises=false
cthmove=false
menuchoice=false
menucthchoice=false
cbtmenuchoise=false
mhero=false
cthenters=false
cthmusic=false
fightcth=false
stay=true
endgame=false
tgthit=false
battlemusic=false
menuselchanged=false
herodies=false
cthulhudies=false
heroconverts=false
finalmusic=false
--counters
selopt=1
currentturn=1
countrei=0
countdialogs=0
countcth=0
cthstatus=0
cthslctopt=1
cbtopt=1

-->8
--loop start here
function _init()
 cls()
 music(1)
end

function _update()
	if not fightcth then
		movecursor()
		checkmenusound()
		cthulhumusic()
	else
		if not endgame then
			changemenusel()
			checkmenusound()
		else
			if herodies then
				if not finalmusic then
						music(3)
					finalmusic=true
				end
			elseif cthulhudies then
				if not finalmusic then
						music(1)
					finalmusic=true
				end
			elseif heroconverts then
				if not finalmusic then
						music(4)
					finalmusic=true
				end
			end
		end
	end
end

function _draw()
	cls()
	if not fightcth then
		map(0,0)
 	drawplaces()
 	spr(hero.sprite,hero.x,hero.y)
  print(reino,97,11,0)
 	print(vila,33,58,0)
 	print(tenda,11,98,0)
 	drawsymbols()
 	herostatus()
 	selecthero()
 	movecthulhu()
 	spr(pc.sprite,pc.x,pc.y)
  initialdialogs()
  options()
  clickmenu()
  optionscth()
  clickmenucth()
  countturn()
  movehero()
 else
 	if not endgame then
 		map(16,0)
 		sspr(16,16,16,16,48,32,32,32)
 		drawfighter()
 		drawcombatmenu()
 		printhearts()
			clickcombatmenu()
			dotheaction()
 	elseif endgame then
 		if herodies then
 			lightningend()
				sspr(32,32,16,16,-8,-4,56,56)
 			sspr(48,32,16,16,77,-4,56,56)
 			sspr(16,32,16,16,36,4,56,56)
 			sspr(64,32,16,16,46,62,28,28)
 			sspr(96,40,16,16,74,74,28,28)
 			print("voce perde o combate para o",8,91,7)
 			print("grande cthulhu. uma vez mais",7,98)
 			print("r'lyeh se erguera e trara",12,105)
 			print("horror para todos.",26,112)
 			print("game over",44,122)
 		elseif cthulhudies then
 			map(32,0)
 			sspr(80,32,16,16,36,36,32,32)
 			sspr(96,32,8,8,52,20,16,16)
 			print("vitoria! cthulhu falhou. r'lyeh",2,77,7)
 			print("continua nas profundesas.",16,84)
 			print("ao dormir, voce tem pesadelos",6,91)
 			print("estranhos. um horror toma",15,98)
 			print("conta de sua mente",26,105)
 			print("cthulhu vive...",34,112)
 			print("game over",44,122)
 		elseif heroconverts then
 			fireend()
 			sspr(32,32,16,16,-8,-4,56,56)
 			sspr(48,32,16,16,77,-4,56,56)
 			sspr(16,32,16,16,36,4,56,56)
 			sspr(0,32,16,16,46,56,32,32)
 			print("voce se junta as fileiras de",8,91,7)
 			print("cultistas. o grande cthulhu",9,98)
 			print("domina novamente.",31,105)
 			print("r'lyeh ergue-se em horror.",13,112)
 			print("game over",44,122)
 		end
 	end
	end	
end
-->8
--general
function initialdialogs()
	if dl then
 	if countdialogs<1 then
 		dialog(intro,3)
 		if btnp(4) then
 			countdialogs+=1
 			dl=true
 		end
 	elseif countdialogs<2 then
  	dialog(intro2,2)
  	if btnp(4) then
  		countdialogs+=1
  		dl=true
  	end
  elseif countdialogs<3 then
 	 dialog(intro3,2)
 	 if btnp(4) then
  	 countdialogs+=1
  	 dl=true
 	 end
 	elseif countdialogs<4 then
  	dialog(intro4,2)
  	if btnp(4) then
   	countdialogs+=1
   	dl=true
  	end
  else
  	dl=false
 	end
 end
end

function drawplaces()
	if not burnrei then
		spr(32,rei.sp1x,rei.sp1y)
		spr(33,rei.sp2x,rei.sp2y)
		spr(48,rei.sp3x,rei.sp3y)
		spr(49,rei.sp4x,rei.sp4y)
	else
		rei.ticks+=1
		if rei.ticks==rei.ticksmax then
		 if rei.frame==rei.framemax then
		 	rei.frame=0
		 else
		 	rei.frame+=1
		 end
		 rei.ticks=0
	 end
		spr(30,rei.sp1x,rei.sp1y)
		spr(rei.firesp1+rei.frame,rei.sp2x,rei.sp2y)
		spr(rei.firesp2+rei.frame,rei.sp3x,rei.sp3y)
		spr(31,rei.sp4x,rei.sp4y)
	end
	if not burnvil then
		spr(17,vil.sp1x,vil.sp1y)
		spr(17,vil.sp2x,vil.sp2y)
	else
 	vil.ticks+=1
		if vil.ticks==vil.ticksmax then
		 if vil.frame==vil.framemax then
		 	vil.frame=0
		 else
		 	vil.frame+=1
		 end
		 vil.ticks=0
	 end
		spr(40,vil.sp1x,vil.sp1y)
		spr(vil.firesp+vil.frame,vil.sp2x,vil.sp2y)
	end
	if not burnten then
		spr(18,ten.sp1x,ten.sp1y)
		spr(18,ten.sp2x,ten.sp2y)
		spr(18,ten.sp3x,ten.sp3y)
	else
 	ten.ticks+=1
		if ten.ticks==ten.ticksmax then
		 if ten.frame==ten.framemax then
		 	ten.frame=0
		 else
		 	ten.frame+=1
		 end
		 ten.ticks=0
	 end
		spr(41,ten.sp1x,ten.sp1y)
		spr(41,ten.sp2x,ten.sp2y)
		spr(ten.firesp+ten.frame,ten.sp3x,ten.sp3y)
	end
end

function drawsymbols()
	spr(42,110,22)
	spr(24,114,20)
	spr(42,49,66)
	spr(25,56,66)
	spr(42,24,109)
	spr(23,31,108)
end

function movecursor()
	if not dl then
		if btn(0) then pc.x-=2	end
 	if btn(1) then	pc.x+=2 end
 	if btn(2) then pc.y-=2 end
 	if btn(3) then pc.y+=2 end
	end
end

function selecthero()
	for i=hero.x,hero.x+8 do
		for j=hero.y,hero.y-8,-1 do
			if i==pc.x and j==pc.y then
				spr(2,hero.x,hero.y)
				if btnp(4) then
					optmenu=true
					play=true
			 end
			end
		end
	end
end

function dialog(text,lines)
	if dl then
		for i=0,lines-1 do
			rectfill(dbox.x0,dbox.y0+i*8,dbox.x1,dbox.y1+i*8,0)
		end
		for i=0, count(text)-1 do
			print(text[i+1],dbox.x0+8,dbox.y0+2+(i*8),7)
		end
		if btnp(4) or btnp(5) then	dl=false	end
	end
end

function options()
	if optmenu then
		dl=true
		dialog(menutext,4)
		spr(menusel.sprite,menusel.x,menusel.y)
		menuchoice=true
		if selopt < 1 then selopt=1
		elseif selopt > 4 then selopt=4
		else
			if btnp(2) then
			 selopt-=1
			 menusel.y-=8
			 if menusel.y<72 then menusel.y=72 end
			elseif btnp(3) then
			 selopt+=1
			 menusel.y+=8
			 if menusel.y>96 then menusel.y=96 end
			end
		end
	end
end

function optionscth()
 if cthrises then
 	if stay then
 		dl=true
 		dialog(menucth,2)
 		spr(menusel.sprite,menusel.x,menusel.y)
 		menucthchoice=true
 		if cthslctopt<1 then cthslctopt=1
 		elseif cthslctopt>2 then cthslctopt=2
 		else
 			if btnp(2) then
 			 selopt-=1
 			 menusel.y-=8
 			 if menusel.y<72 then menusel.y=72 end
 			elseif btnp(3) then
 			 selopt+=1
 			 menusel.y+=8
 			 if menusel.y>96 then menusel.y=96 end
 			end
 		end
 	end
 end
end

function clickmenu()
	if menuchoice then
		if btnp(5) then
			play=true
			optmenu=false		
 		selopt=1
 		menusel.y=72
 		countrei=0
 		gamestatus="inicio"
 	elseif btnp(4) then
 		if selopt==4 then
 			play=true
  		optmenu=false		
  		selopt=1
  		menusel.y=72
  		countrei=0
  		gamestatus="inicio"
  	elseif selopt==1 then
  		play=true
  		gamestatus="reino"
  	elseif selopt==2 then
  		play=true
  		gamestatus="vila"
  	elseif selopt==3 then
  		play=true
  		gamestatus="tenda"
  	end
		end
		menuchoice=false
	end
end

function clickmenucth()
	if cthrises then
 	if menucthchoice then
 		if btnp(5) then
 			play=true
 			optmenu=false		
  		selopt=1
  		menusel.y=72
  		countrei=0
  		gamestatus="inicio"
  		stay=false
  	elseif btnp(4) then
  		if selopt==2 then
  			play=true
   		optmenu=false		
   		selopt=1
   		menusel.y=72
   		countrei=0
   		gamestatus="inicio"
   		stay=false
   	elseif selopt==1 then
   		play=true
   		optmenu=false
   		gamestatus="lutar"
   		stay=false
   		fightcth=true
   	end
 		end
 		menucthchoice=false
 	end
	end
end

function countturn()
	print("turno: "..tostr(currentturn),92,122,0)
end

function drawcthulhu()
	spr(34,cth.sp1x,cth.sp1y)
	spr(35,cth.sp2x,cth.sp2y)
	spr(50,cth.sp3x,cth.sp3y)
	spr(51,cth.sp4x,cth.sp4y)
end

function drawherofight()
	spr(55,herofight.sp1x,herofight.sp1y)
	spr(56,herofight.sp2x,herofight.sp2y)
	spr(57,herofight.sp3x,herofight.sp3y)
	spr(58,herofight.sp4x,herofight.sp4y)
end

function herostatus()
	for i=0,hero.life-1 do
		spr(25,hero.lifex+(i*8),hero.lifey)
	end
	for i=0,hero.attack-1 do
		spr(24,hero.attackx+(i*8),hero.attacky)
	end
	for i=0,hero.defense-1 do
			spr(23,hero.defensex+(i*8),hero.defensey)
	end
end
-->8
--move functions
function movehero()
	if btnp(4) then
		if gamestatus=="reino" then
			gamestatus="inicio" 		
 	 countrei+=1
 		if countrei%2==0 then
 			hero.x=100
 			hero.y=25
 			currentturn+=1
 			risecth()
  		optmenu=false		
  		selopt=1
  		menusel.y=72
  		countrei=0
  		if not stay then stay=true end
  		if not burnrei then
  			hero.attack+=1
  		end
  		if hero.attack>10 then hero.attack=10 end
  		gamestatus="inicio"
  		if cthrises then cthmove=true end
 		end		
 	elseif gamestatus=="vila" then
 		currentturn+=1
 		risecth()
 		hero.x=40
 		hero.y=72 		
 		optmenu=false		
 		selopt=1
 		menusel.y=72
 		countrei=0
 		if not stay then stay=true end
 		if not burnvil then
 			hero.life+=1
 		end
 		if hero.life>10 then hero.life=10 end
 		gamestatus="inicio"
 		if cthrises then cthmove=true end
 	elseif gamestatus=="tenda" then
			currentturn+=1
			risecth()
			hero.x=16
			hero.y=104
			optmenu=false		
 		selopt=1
 		menusel.y=72
 		countrei=0
 		if not stay then stay=true end
 		if not burnten then
 			hero.defense+=1
 		end
 		if hero.defense>10 then hero.defense=10 end
 		gamestatus="inicio"
 		if cthrises then cthmove=true end
		end
	end
end

function movecthulhu()
	if cthrises then
		if cthmove then
			local n=rnd(3)
			if n<1 then
				cth.sp1x=88
    cth.sp1y=8
    cth.sp2x=96
    cth.sp2y=8
    cth.sp3x=88
    cth.sp3y=16
    cth.sp4x=96
    cth.sp4y=16
    drawcthulhu()
    cthmove=false
    burnrei=true
    cthstatus=1
			elseif n>=1 and n<2 then
				cth.sp1x=24
    cth.sp1y=56
    cth.sp2x=32
    cth.sp2y=56
    cth.sp3x=24
    cth.sp3y=64
    cth.sp4x=32
    cth.sp4y=64
    cthmove=false
 			drawcthulhu()
 			burnvil=true
 			cthstatus=2
			elseif n>=2 then
 			cth.sp1x=0
    cth.sp1y=96
    cth.sp2x=8
    cth.sp2y=96
    cth.sp3x=0
    cth.sp3y=104
    cth.sp4x=8
    cth.sp4y=104
    cthmove=false
 			drawcthulhu()
 			burnten=true
 			cthstatus=3
			end
			else
 			drawcthulhu()
		end
	end
end

function risecth ()
	if currentturn>3 and not cthenters then
		local n=rnd(3)
		if n<1 then
			cthrises=true
			cthmove=true
			cthenters=true
		end
	end
end
-->8
--music and sound
function checkmenusound()
	if play then sfx(0) end
	play=false
end

function cthulhumusic()
	if cthrises then
		if not cthmusic then
		sfx(6)
 	music(0)
 	cthmusic=true
		end
	end
end

function hit()
	if tgthit then sfx(8) end
	tgthit=false
end
-->8
--combat system
function changemenusel()
	if not menuselchanged then
		menusel.x=32
		menusel.y=104
		menuselchanged=true
	end
end

function drawcombatmenu()
	if not endgame then
		combatdialog(combattext)
		spr(menusel.sprite,menusel.x,menusel.y)
		cbtmenuchoise=true
		if cbtopt < 1 then cbtopt=1
		elseif cbtopt > 3 then cbtopt=3
		else
			if btnp(2) then
			 cbtopt-=1
			 menusel.y-=8
			 if menusel.y<104 then menusel.y=104 end
			elseif btnp(3) then
			 cbtopt+=1
			 menusel.y+=8
			 if menusel.y>120 then menusel.y=120 end
			end
		end
	end
end

function clickcombatmenu()
	if not endgame then
		--if cbtmenuchoise then
			if btnp(4) then
				play=true
				if cbtopt==1 then
					combatstatus="ataca"
					menusel.y=104
				elseif cbtopt==2 then
					combatstatus="defende"
					menusel.y=104
				elseif cbtopt==3 then
					combatstatus="render"
					menusel.y=104					
				end
			end
	--	end
	end
end

function dotheaction()
	if btnp(4) then
		if combatstatus=="ataca" then
			calculatedamage()
			combatstatus="combate"
		elseif combatstatus=="defende" then
			calculatedamage()
			combatstatus="combate"
		elseif combatstatus=="render" then
			combatstatus="combate"
			heroconverts=true
			endgame=true
			music(-1)
		end
	end
end

function combatdialog(text)
	for i=0,2 do
		rectfill(32,104+i*8,96,120+i*8,0)
	end
	for i=0, count(text)-1 do
		print(text[i+1],40,106+(i*8),7)
	end
end

function drawfighter()
	spr(55,80,80)
	spr(56,88,80)
	spr(57,80,88)
	spr(58,88,88)
end

function calculatedamage()
	--hero damage
	local n=rnd(2)
	local heroattack=0
	local herodefense=0
	local cthattack=0
	local cthdefense=0
	local dmgivenhero=0
	local dmggivencth=0

	if combatstatus=="ataca" then
		combatstatus="combate"
		local n=rnd(3)
		if n<2 then
			local x=flr(hero.attack/2)
 		heroattack=x+hero.attack	
 		herodefense=hero.defense
 	end	
	elseif combatstatus=="defende" then
		combatstatus="combate"
		local n=rnd(3)
		if n<2 then
 		local x=flr(hero.defense/2)
 		heroattack=hero.attack
 		herodefense=x+hero.defense
 	end
	end

	--cthulhu damage

	local m=rnd(3)
	if m<1 then
		--cthulhu attack
		local x=flr(cth.attack/2)
		cthattack=x+cth.attack
		cthdefense=cth.defense
	elseif m>1 and m<2 then
		--cthulhu defends
		local x=flr(cth.defense/2)
		cthattack=cth.attack+x
		cthdefense=cth.defense
	end
	--calculate the total damage
	dmgivenhero=cthattack-herodefense
	dmggivencth=heroattack-cthdefense
	if dmgivenhero<0 then
		dmgivenhero=0
	end
	if dmggivencth<0 then
		dmggivencth=0
	end
	cth.life-=dmggivencth
	hero.life-=dmgivenhero
	tgthit=true
	hit()
	if hero.life<=0 then
		herodies=true
		endgame=true
		music(-1)
	end
	if cth.life<=0 then
		cthulhudies=true
		endgame=true
		music(-1)
	end
end

function printhearts()
	for i=0,hero.life-1 do
		spr(25,hero.lifex+(i*8),hero.lifey)
	end	
	for i=cth.life-1,0,-1 do
		if i>4 then
			spr(59,cth.lifex-(i*8)+40,cth.lifey+8)
		else
			spr(59,cth.lifex-(i*8),cth.lifey)
		end
	end
end
-->8
--ending functions
function fireend()
	fireani.ticks+=1
	if fireani.ticks==fireani.ticksmax then
		if fireani.frame==fireani.framemax then
			fireani.frame=0
		else
			fireani.frame+=1
		end
		fireani.ticks=0
	end
	spr(fireani.sp+fireani.frame,6,38)
	spr(fireani.sp+fireani.frame,22,68)
	spr(fireani.sp+fireani.frame,82,78)
	spr(fireani.sp+fireani.frame,114,58)
	spr(fireani.sp+fireani.frame,32,120)
	spr(fireani.sp+fireani.frame,-1,100)
	spr(fireani.sp+fireani.frame,118,112)
end

function lightningend()
	lghani.ticks+=1
	if lghani.ticks==lghani.ticksmax then
		if lghani.frame==lghani.framemax then
			lghani.frame=0
		else
			lghani.frame+=1
		end
		lghani.ticks=0
	end
	spr(lghani.sp1+lghani.frame,72,0)
	spr(lghani.sp2+lghani.frame,72,8)
	spr(lghani.sp1+lghani.frame,116,16)
	spr(lghani.sp2+lghani.frame,116,24)
	sspr(0+(lghani.frame*8),48,8,16,-2,-1,16,32)
end
__gfx__
0000000000550000cc0000cc333333333333333333333333ffffffff333333333ffffffffffffff3cccccccc33333333333333333cccccccccccccc33333333c
0000000005775000c000000c3333333333333333fffff333ffffffff333fffff3ffffffffffffff3cccccccc333cccccccccc3333cccccccccccccc333333333
0070070005777500c000000c3333333333333333ffffff33ffffffff33ffffff3ffffffffffffff3cccccccc33cccccccccccc333cccccccccccccc333333333
0007700057777500000000003333333333333333fffffff3ffffffff3fffffff3ffffffffffffff3cccccccc3cccccccccccccc33cccccccccccccc333333333
0007700005775000000000003333b33333333333fffffff3ffffffff3fffffff3ffffffffffffff3cccccccc3cccccccccccccc33cccccccccccccc333333333
0070070005750000c000000c3333bb3333333333fffffff3ffffffff3fffffff33ffffffffffff33cccccccc3cccccccccccccc333cccccccccccc3333333333
0000000005750000c000000c333bbbb333333333fffffff3ffffffff3fffffff333ffffffffff333cccccccc3cccccccccccccc3333cccccccccc33333333333
0000000000500000cc0000cc3333333333333333fffffff3ffffffff3fffffff3333333333333333cccccccc3cccccccccccccc3333333333333333333333333
0055550033333333ffffffffcccccccc3333533333333bbb00000000666666556500000008800820355386633553686333333833333383333333333363663533
0544445033331113fff99fffcc5555cc3333543333bbbbbb00000000611111156650000088888882335898333353898333338983333898333338883336333353
05c44c5033311111ff9999ffc566665c3335555333bbb343000700006aaaaaa50665000088888882353899833538998335389983353899833353e65333333553
05444450333fffffff9999ff5666666533455553bbb43bbb00077000611aa115006650a088888882355333383553383338335333383353333556683833335533
0aa44aa0338886fff99d999f6655556635555553bbb33bbb00077700611aa11500066a0008888820335553893355898388833533883835333353888855535553
04aaaa4038888833f99dd99f65cccc5645555555343bbb4300077000661aa1550000a6000088820033553899335589986e9833536e898353355666e633555333
001111003fffff33ffffffff5cccccc545555554333bbb3300070000066aa550000a00600008200033cccccc33cccccc389985533899855335533666cccccc33
001001003ff6ff33ffffffffcccccccc55555554333343330000000000666500000000010000000033333339333333396366335363663353353366e633333333
333383333333333300000000000000003833338338333833ffffff8fffffffff33333333ffffffff0000000011111111111111111aaaa11111111111fffffbbb
333888333333333300000055550000003983189889338983fff99898fff98fff33333313fff9ffff0005000011111aaaaaa111111aaaa11111111111ffffbbbb
3356e6555555553300500533bb5005003331899833318998ff9f8998ff9898ff33311311ff9f9fff00575000111aaaaaaaaaa1111aaaaa1111111a11fffbbbbb
35566888888355530535533333b55b50333fff3f333fff3fff989998ff98998f333ffff3ff9999ff0577750011aaaaaaaaaaaa111aaaaaa1111aaa11ffbbbbbb
35568888888835535335533333b553b5333836ff333836fff9989998f9989998338833fff99d9f9f0057500011aaaaa1111aaa1111aaaaaaaaaaaa11ffbbbbbb
355666e66e6635535335535335b553b53888883338888833f9ff888ff9ff888f38383833ff9fd9ff000500001aaaaa1111111a1111aaaaaaaaaaa111ffbbbbbb
35536666666635535333538338b533b53fff3f333fff3f33ffffffffffffffff3fff3f33ffffffff000000001aaaa11111111111111aaaaaaaaa1111fbbbbbbb
355366e66e66355353333533335333b533f3ff3333f3ff33ffffffffffffffff3f36f333ffffffff000000001aaaa1111111111111111aaaaaa11111bbbbbbbb
35536666666635535333333533333bb5bbbbbbbb1111111111111111000000000000000000066664455560000bb00b3011111ffffff11111bbffffff00000000
35536669966635530533353353533b50bbbbbbbb111111111115111100000000000000000006555444556000bbbbbbb3111ffffffffff111bbbbffff00000000
35533333333335530055553533555500bbbbbbbb111111111157511100000000000000000006554aaaaaa000bbbbbbb311ffffffffffff11bbbbbfff00000000
35553333333355530553335335353b50bbbbbbbb111111111577751100000005555600000006554aaaaaa000bbbbbbb31ffffffffffffff1bbbbbfff00000000
3555555555555553533555535b5b55b5bbbbbbbb1111111111575111000000055555600000006544aaaa40000bbbbb30ffffffffffffffffbbbbbbff00000000
3355556666555533055005355b550050bbbbbbbb11111111111511110000000445556000000006601111000000bbb300ffffffffffffffffbbbbbbff00000000
33ccccc99ccccc3300005350b5500000bbbbbbbb11111111111111110000000c4555600000000000111c0000000b3000ffffffffffffffffbbbbbbbf00000000
33333339933333330000053055000000bbbbbbbb1111111111111111000000044555600000000000100c000000000000ffffffffffffffffbbbbbbbb00000000
00000000000000000000000000000000000000000000500000050000000000000000000000000000000000000665000000000000000008000000800008000000
00000011ccc00000000000555000000000000000000550000005500000000000600a000000000000000000000665000000000000000008800008980089800000
00000111111c000000005533355000000000000000533500005335000000000006a0000000000000000000000665000000000000000889800008980089880000
000011111111c0000005333333350000000000000533b350053b3350000000000a65000000000000000000000665000000000000008899800008980089988000
000010001000c000005333333333500000000000533b33355333b33500000000a066500000000000000000000665000000000000008999800089998089999800
000010800080c00000533833383350000000000533b333b33b333b3350000000000665110011100000005555aaaaa00000600000089999800089999889999980
000010080800c00000533383833350000000000533b33b3333b33b3350000000000066511111100000054c4c4440000006650000899999980899999808999998
000011000001c0000053333333335000000000533b333b3333b333b335000000000a888aaa111066000544444aa0000006650000899999988999999808999998
001111000001ccc0000533333335000500000053b0b333b33b333b0b3500000000aaaaaaaa110061000544444aa0000066600000000000000000000000000000
01111111011111cc000053333350000500000005000b33b33b33b000500000000a555555aa0006aa00aaaaaaaaa000001a160000000000000000000000000000
0111c1113131c1115303bb333b35505300000000000b333bb333b00000000000a55555555aa006aa66666aaaaaa00000aa160000000000000000000000000000
011c113113111c11053b0b3b3b303330000000000000b3b00b3b000000000000a55555555aa0066161116aaaa0000000aa160000000000000000000000000000
011c313131311c110000030b03b300000000000000000b0000b0000000000000a45555554aa000066aaa6aaaa00000001a160000000000000000000000000000
011c311311111c11550030b30300500000000000000000000000000000000000084444440440000061a161111000000066600000000000000000000000000000
011c313133111c11005350300b30355000000000000000000000000000000000088888884440000006a611011000000000000000000000000000000000000000
011c131111111c110000005000500000000000000000000000000000000000000088888888000000006011011000000000000000000000000000000000000000
000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000a0000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000a00000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000a000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000aa000000606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00a0a000006606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00a0a000060600600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a000a00060600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a000a00600060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000a0a0060060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a0000000606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00a00000006000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00a00000060600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00a00000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3
f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f30000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3
f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f30000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3
f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f30000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3
f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f30000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3
f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f30000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1414030a141414040403031515151504353535353535363535353535353535353f3f2a3f3f2a3f2a3f3f2a3f2a3f3f2a3f3f3f3f3f3f3f3f3f3f3f3f3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414140a141414140404150304041515353535363535353535363535363535353f2a002a3f3f3f3f3f2a3f3f3f2a3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414140a041414031515040404040415353635353535353635353535352b2c353f3f3f3f2a3f3f2a3f3f3f2a3f3f3f3f2a3f3f3f3f3f3f3f3f3f3f3f3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1415030a030415151515150304040415353535353536353535363535352d2e353f3f2a3f3f3f003f3f3f3f3f3f3f2a3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
1403030d0c0315151515030403040403353536353535353535353536353535362a3f3f3f3f2a003f3f2a3f3f2a3f3f3f2a3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
140403040d0a0c03030304040403030435353535353535363535353535353535003f3f3f3f003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404041515040d0a0c04151515030403353535353535353535353535363536353f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
040415150404150f1304031515151504353535353635353535363535353535353f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
04040403040404040d0c040403151504353635353535363535353535353536353f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
0404040403040403030d0c0403031504353535353535353535353535353535353f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
040404040415040403030d0a0a0a0a0a353535353535353535353535353535353f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606050404040404040303041515033c06060606060606060606060606063d3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060605040404040403030415042f34343e0606060606060606062f34343f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
060606060606060504040404030304043434343434343e060606062f34343434003f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
06060606060606060605040404040404343434343434343434343434343434343f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
06060606060606060606040404040404343434343434343434343434343434343f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f3f0000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0101000000000000000000000000000000455006550085500a5500b5500d5500f55010550125501455016550185501a5501d5501f550215500000000000000000000000000000000000000000000000000000000
011700200f5321e032220322e0320f5321e032220322f0320f5321e032220322e0320f5321e03222032200320d5322e0322c032250320d5322e0322c0322f0320d5322e0322c032250320d5322e0322c03219032
011700200305300000000000300003053030000100000000030530000000000000000305300000000000000001053000000000000000010530000000000000000105300000000000000001053000000000000000
011700200374200000037320000003732000000373200000037320000003732000000373200000037320000001732000000173200000017320000001732000000173200000017320000001732000000173200000
011e00200e150121500e150121500e150121500e150121500e150141500e150141500e150141500e150141500d150151500d150151500d150151500d150151500b150171500b150191500b1501a1500b1501c150
011e00201a0501a0501a0501a0501a0501a0501a0501a0501c0501c0501c0501c0501c0501c0501a0501c0501e0501e0501e0501e0501e0501e0501e0501e0502105021050210502105021050210502105021050
01100000236500c650236500c650236500c650236500c650236500c65000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0110000003752097520f752187521e752257522a75216752087520375200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000003f5503f6503f6003f1003f1003f6003f3003f3003f4003c6001c0001d0001d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010a000011350113500d30011350003000f3500f35011350113500030011350003001135011350113500000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01180020141521415212152101520f1520d1520d1520d15215152151521415212152101520f1520f1520f152141521415212152101520f1520d1520d1520d1520b1520b1520f152101520f1520d1520d1520d152
01180020000000d3500000001300000000d35000000013000000012350000000630000000123500000006300000000b350000000b300000000b350000000b30000000103500000004300000000f3500000003300
011800202555025550255500050000000000002850027550285502350000500005000050019500000001b50023550235502355000500005000050027500255502755000500005000050000500005000050000000
011400201655216552115521155210552105520f5520f5521655216552115521155210552105520f5520f5521755217552145521455211552115520f5520f5521755217552145521455211552115520f5520f552
011400200000000000037500375003700007000375003750037000070003750037500370000700037500375003700007000175001750017000070001750017500170000700017500175001700007000175001750
__music__
03 01034344
03 04054344
03 094a4344
03 0a0b0c4b
03 0d0e4344

