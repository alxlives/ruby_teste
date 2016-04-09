$( document ).ready(function() {

//=========== VAR CONFIGURATION ========================

	var base_url = "http://localhost:3000";
	var txt_name = document.getElementById("nome");
	var txt_email = document.getElementById("email");
	var btn_login = $("#btLogin");
	var btn_logoff = $("#btLogoff");

//========== END VAR CONFIGURATION ======================

	var title = document.getElementsByTagName("title")[0].innerHTML;


	var array_user = JSON.parse(readCookie("railsTracker"));

	if(array_user != null && array_user[0] != null && array_user[0] != ""){
		saveAccess(array_user[0]);
	}

	btn_logoff.click(function(){
		resetCookie();
		window.alert("user deslogado");
	});

	btn_login.click(function(){

		var nome = document.getElementById("nome").value;
		var email = document.getElementById("email").value;

		if (ValidaForm() == true){

			$.ajax({
				type: "POST",
				dataType: "json",
				url: base_url+"/contatosCreate",
				data: {contatos: {nome: nome, email: email}},
				success: function (data) {

					var id = data.contato.id;
					var nome = data.contato.nome;
					var email = data.contato.email;

					saveCookie(id, nome, email);
					saveAccess(id);

					window.alert("login feito com sucesso");

				},
			});

		}

	});

	function saveAccess(id){
		$.ajax({
			type: "POST",
			dataType: "json",
			url: base_url+"/acessosCreate",
			data: {acessos: {contato_id: id, pagina: title}},
			success: function (data) {
				window.alert("acesso criado com sucesso");
			},
		});
	}

	function saveCookie(id,nome,email) {
		var arrayValues = [id, nome, email];
		document.cookie = "railsTracker="+JSON.stringify(arrayValues);
	}

	function readCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for(var i=0;i < ca.length;i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1,c.length);
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	}

	function resetCookie(){
		document.cookie = "railsTracker=[null, null, null]";
	}

	function ValidaForm(){
		var nome = txt_name.value;
		var email = txt_email.value;

	    if (nome == ""){
	        alert("O campo nome deve ser preenchido!");
	        return false;
	    }

	    if (email == ""){
	        alert("O campo email deve ser preenchido!");
	        return false;
	    }    
	    
	    parte1 = email.indexOf("@");
	    parte3 = email.length;
	    if (!(parte1 >= 3 && parte3 >= 9)) {
	        alert("O campo email deve ser conter um endereço eletrônico!");
	        return false;
	    }

		return true;
	}

});


