if (Lang == undefined) {
	var Lang = [];
}
Lang['br'] = {
	confim_buy:"Você deseja realmente comprar este posto? Preço: {0}", 
	confim_buy_title:"Você tem certeza?", 
	confim_buy_cancel_button:"Cancelar", 
	confim_buy_confirm_button:"Confirmar", 
	confim_sell_title:"Você tem certeza?", 
	confim_sell_desc:"Você realmente quer vender sua loja? Tudo será excluído e este processo não pode ser desfeito.", 
	confim_sell_cancel_button:"Cancelar", 
	confim_sell_confirm_button:"Vender", 
	str_low_stock:"Ficar com POUCO ESTOQUE fará você perder seu posto!",
	str_stock_capacity:"Capacidade do estoque (Max: {0})",
	str_gas_price:"Preço do litro de combustível",
	btn_apply_price:"Aplicar preço",
	str_liters:"Litros",
	btn_import:"Importar",
	btn_export:"Exportar",
	str_amount:"Quantidade",
	str_reward:"Salário",
	str_total_cost:"Custo total",
	btn_delete_contract:"Deletar contrato",
	str_stock_capacity_title:"Capacidade de estoque",
	str_stock_capacity_desc:"Melhore sua capacidade de estoque para obter mais espaço para armazenar seus produtos. Seus produtos serão vendidos apenas quando alguém vier à sua loja ou quando você exportá-los.",
	str_truck_capacity_title:"Capacidade do caminhão",
	str_truck_capacity_desc:"Melhore a capacidade do seu caminhão para obter um caminhão melhor para transportar uma maior quantidade de produtos.",
	str_relationship_title:"Relacionamento",
	str_relationship_desc:"Quanto melhor for o seu relacionamento com os fornecedores, melhores serão os preços de compra. Você receberá o desconto ao começar um novo trabalho.",
	str_level:"Level",
	str_units:"unidades.",
	str_capacity:"capacidade.",
	str_discount:"desconto.",
	btn_buy:"Comprar",
	str_price:"Valor",
	str_date:"Data",
	str_fill_field:"Preencha este campo",
	str_invalid_value:"Valor inválido",
	str_more_than:"Deve ser maior ou igual a {0}",
	str_less_than:"Deve ser menor ou igual a {0}",
	str_income_expenses:"Receitas / Despesas:",

	str_main_page_title_navbar:"Seu posto de combustível",
	str_goods_page_title_navbar:"Combustível",
	str_jobs_page_title_navbar:"Reabastecer",
	str_hire_page_title_navbar:"Contratar motorista",
	str_upgrades_page_title_navbar:"Upgrades",
	str_employee_page_title_navbar: "Funcionários",
	str_bank_page_title_navbar:"Caixa",
	str_sell_page_title_navbar:"Vender loja",

	str_main_page_title:"Estatísticas",
	str_main_page_desc:"Estatísticas do seu posto de combustível",
	str_main_page_money_earned:"Total de dinheiro ganho",
	str_main_page_money_spent:"Total de dinheiro gasto",
	str_main_page_money_spent:"Total de dinheiro gasto",
	str_main_page_goods:"Litros importados",
	str_main_page_distance_traveled:"Distância viajada",
	str_main_page_total_visits:"Visitas totais",
	str_main_page_customers:"Clientes",
	
	str_goods_page_title:"Estoque de combustível",
	str_goods_page_desc:"Aqui você pode ver o seu armazenamento de combustível do seu posto. Você também pode alterar o preço do litro de combustível do seu posto.",
	
	str_jobs_page_title:"Reabastecimento",
	str_jobs_page_desc:"Reabasteça os reservatórios do seu posto através da importação de combustível.",

	str_hire_page_title:"Contratar motorista",
	str_hire_page_desc:"Aqui você pode criar empregos para motoristas importarem combustível para seu posto. É importante colocar um salário alto para incentivar as pessoas a aceitarem os trabalhos.",
	str_hire_page_form_job_name:"Nome do trabalho",
	str_hire_page_form_reward:"Salário",
	str_hire_page_form_amount:"Quantidade",
	btn_hire_page_form:"Criar trabalho",

	str_upgrades_page_title:"Upgrades",
	str_upgrades_page_desc:"Use seu dinheiro para melhorar seu posto e obter mais lucro",

	employees_title: 'Funcionários',
	employees_desc: 'Contrate funcionários para trabalhar em sua empresa',
	button_employee: 'Contratar funcionário',
	button_fire_employee: 'Demitir',
	button_give_comission: 'Dar comissão',
	input_give_comission: 'Valor da comissão',
	hired_date: 'Contratado em:',
	jobs_done: 'Trabalhos concluídos:',
	select_employee: 'Selecione um usuário',
	basic_access: 'Acesso Básico',
	advanced_access: 'Acesso Avançado',
	full_access: 'Acesso Total',

	str_bank_page_title:"Caixa",
	str_bank_page_desc:"Veja todo o seu fluxo de caixa aqui. Você pode depositar e sacar seu dinheiro",
	str_bank_page_total_money:"Dinheiro total:",
	str_bank_page_withdraw:"Clique para sacar",
	btn_bank_page_deposit:"Depositar dinheiro",
	str_bank_page_hidden_balance: "Mostrar saldo oculto",

	str_rename_store:"Nomear loja",
	str_rename_store_desc:"Selecione aqui qual nome você quer dar para sua loja",
	btn_apply_rename:"Aplicar",
	str_rename_store_name:"Nome da loja",
	html_select_colors:`
		<option value="" selected disabled>Selecione a cor</option>
		<option color_id="1">Vermelho</option>
		<option color_id="3">Azul</option>
		<option color_id="4">Branco</option>
		<option color_id="5">Amarelo</option>
		<option color_id="7">Violeta</option>
		<option color_id="8">Rosa</option>
		<option color_id="15">Ciano</option>
		<option color_id="22">Cinza</option>
		<option color_id="29">Azul escuro</option>
		<option color_id="30">Ciano escuro</option>
		<option color_id="32">Azul claro</option>
		<option color_id="40">Cinza escuro</option>
		<option color_id="41">Vermelho Claro (Default)</option>
		<option color_id="46">Ouro</option>
		<option color_id="47">Laranja</option>
		<option color_id="83">Roxo</option>
	`, // Change only the color names

	html_select_type:`
		<option value="" selected disabled>Selecione o tipo</option>
		<option blip_id="40">Safe House</option>
		<option blip_id="50">Garage</option>
		<option blip_id="51">Drugs</option>
		<option blip_id="52">Market</option>
		<option blip_id="68">Tow truck</option>
		<option blip_id="71">Barber</option>
		<option blip_id="135">Cinema</option>
		<option blip_id="226">Bike</option>
		<option blip_id="227">Car</option>
		<option blip_id="251">Plane</option>
		<option blip_id="273">Dog bone</option>
		<option blip_id="361">Jerry can (Default)</option>
		<option blip_id="357">Dock</option>
	` // Change only the location names
};