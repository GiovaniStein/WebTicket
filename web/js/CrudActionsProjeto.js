$(document).ready(function () {
    $('#cadastraProjeto').click(function (event) {
        event.preventDefault();
        if (valida_form_projeto() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadProjeto",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formProjeto').each(function () {
                        this.reset();
                    });
                    $("#listadeProjetos").load("listaProjetos.jsp");
                }
            });
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});


function valida_form_projeto() {
    if ((document.getElementById("descricaoProjeto").value === null || document.getElementById("descricaoProjeto").value === "")) {
        return false;
    } else {
        return true;
    }
}

function removeProjeto(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover esse projeto?",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sim',
        cancelButtonText: 'Não'
    }).then(function (isConfirm) {
        if (isConfirm.value) {
            $.ajax({
                type: "GET",
                url: '/WebTicket/acao?parametro=exProjeto&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover projeto!", resultado, "error");
                } else {
                    swal("Projeto removido com sucesso!", "", "success");
                    $("#listadeProjetos").load("listaProjetos.jsp");
                }
            });
            return false;
        }
    });
}

function editProjeto(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    $('#idprojeto').val(td[0].innerText);
    $('#descricaoProjeto').val(td[1].innerText);
}


