Sitema simples para emprego de Costureiro com animaçao
 
No server.cfg
start costura_fabricar
start costura_coletar

Comando /use colete   e comando /use mochila

adicionar o grupo Costureiro
vrp/cfg/groups.lua

["Costura"] = {

	_config = {
		title = "Costura",
		gtype = "job"
		},
		"costura.permissao"	
	},

adicionar os itens  
vrp/cfg/items.lua

["pano"] = {"Tecido", 0.3},

["colete"] = {"Colete", 1.5},

["linha"] = {"Linha de Costura", 0.1},

blip do local 
vrp/cfg/blips_markers.lua

{ 717.72,-964.61,30.39,366,13,"Central | Costura",0.5 },

INVENTARIO 
vrp/cfg/inventory.lua

["costura"] = {
      weight = 2500,
      permissions = {"costura.permissao"},
  },


cfg.static_chests = {

{ "costura",707.00,-959.67,30.39 },

}
