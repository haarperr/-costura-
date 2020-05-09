local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("costura_coletar")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX = 707.26
local CoordenadaY = -966.93
local CoordenadaZ = 30.41
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS   40283203,78222656,8852081299
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
   --[1] = { ['x'] = 705.76,['y'] = -963.75,['z'] = 30.39 }, -- loc para TESTE
	[1] = { ['x'] = 1381.92, ['y'] = -1544.70, ['z'] = 57.10 },
	[2] = { ['x'] =   1229.59, ['y'] = -725.38, ['z'] = 60.95 },
	[3] = { ['x'] = 1899.12, ['y'] = 3781.42, ['z'] = 32.87},
	[4] = { ['x'] = 1385.50, ['y'] = 3659.51, ['z'] = 34.92},
	[5] = { ['x'] =1366.05, ['y'] = 4358.08, ['z'] = 44.50},
	[6] = { ['x'] =  2564.87, ['y'] = 4680.44, ['z'] =34.08 },
	[7] = { ['x'] = 2393.57, ['y'] = 3321.65, ['z'] = 47.71 },
	[8] = { ['x'] = 2352.64, ['y'] = 2523.22, ['z'] = 47.68 },
	[9] = { ['x'] = -9.18, ['y'] = 6653.56, ['z'] = 31.25 },
	[10] = { ['x'] = -96.82, ['y'] = 6324.25, ['z'] = 31.57 },
	[11] = { ['x'] = -3205.48, ['y'] = 1152.44, ['z'] = 9.66 },
   [12] = { ['x'] = -3088.89, ['y'] = 392.21, ['z'] = 11.447 },
	[13] = { ['x'] = -1931.91, ['y'] = 162.48, ['z'] = 84.65 },
	[14] = { ['x'] = -1369.16, ['y'] = -136.26, ['z'] = 49.57 },
	[15] = { ['x'] = -1876.90, ['y'] = -584.35, ['z'] =11.85 },
	[16] = { ['x'] = -1113.86, ['y'] = -1193.78, ['z'] = 2.37 },
	[17] = { ['x'] = -1.96, ['y'] = -1442.09, ['z'] = 30.96 },
   [18] = { ['x'] = 130.39, ['y'] = -1853.16, ['z'] = 25.23 },
	[19] = { ['x'] = 1289.37, ['y'] = -1710.45, ['z'] = 55.47 },
	[20] = { ['x'] = 123.95, ['y'] = 64.71, ['z'] = 79.74 },


}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.5,0,0,0,0,180.0,130.0,1.0,1.0,0.5,240,0,0,30,1,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						servico = true
						selecionado = 1
						CriandoBlip(locs,selecionado)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.7,0,0,0,0,180.0,130.0,1.0,1.0,0.5,240,200,80,30,1,0,0,1)
				if distance <= 1.5 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA COLETAR OS ITENS",4,0.5,0.93,0.50,255,255,255,180)
               if IsControlJustPressed(0,38) then
                  if emP.checkPayment() then
                     RemoveBlip(blips)
                     if selecionado == #locs then
                        selecionado = 1
                     else
                        selecionado = selecionado + 1
                     end
                     CriandoBlip(locs,selecionado)
                  end
					end
				end
			end
      end
	end
end)

Citizen.CreateThread(function()
	while true do
      Citizen.Wait(1)
      if servico then
			drawTxt("~y~PRESSIONE ~r~F7 ~w~SE DESEJA FINALIZAR A ROTA ",4,0.270,0.905,0.45,255,255,255,200)
			drawTxt("VA ATÉ O DESTINO PARA COLETAR OS ~g~ITENS",4,0.270,0.93,0.45,255,255,255,200)
      end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Itens")
	EndTextCommandSetBlipName(blips)
end
