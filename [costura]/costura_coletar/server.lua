local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("costura_coletar",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
   local user_id = vRP.getUserId(source)
   local quantp = math.random(7) -- quantidade pano
   local quantl = math.random(7) --quantidade linha
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pano") <= vRP.getInventoryMaxWeight(user_id) then
         vRP.giveInventoryItem(user_id,"pano",quantp)
         vRP.giveInventoryItem(user_id,"linha",quantl)
         TriggerClientEvent("Notify",source,"sucesso","<b>Voçê Recebeu "..quantp.."x Tecido</b>")
         TriggerClientEvent("Notify",source,"sucesso","<b>Voçê Recebeu "..quantl.."x Linha de Costura</b>")
         return true
      else
         TriggerClientEvent("Notify",source,"negado","<b>Inventário Cheio</b>.")
		end
	end
end
math.random(2)
