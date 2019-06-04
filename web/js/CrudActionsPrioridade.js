$(document).ready(function () {
    $('#cadastraPrioridade').click(function (event) {
        event.preventDefault();
        if (valida_form_prioridade() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadPrioridade",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                    //$('#idDescricao').focus();
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formPrioridade').each(function () {
                        this.reset();
                    });
                    $("#listadePrioridade").load("listaPrioridades.jsp");
                }
            });
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});

function valida_form_prioridade() {
    if ((document.getElementById("prioridadeDescricao").value === null || document.getElementById("prioridadeDescricao").value === "")) {
        return false;
    } else {
        return true;
    }
}

function removePrioridade(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover essa prioridade?",
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
                url: '/WebTicket/acao?parametro=exPrioridade&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover prioridade!", resultado, "error");
                } else {
                    swal("Prioridade removida com sucesso!", "", "success");
                    $("#listadePrioridade").load("listaPrioridades.jsp");
                }
            });
            return false;
        }
    });
}

function editPrioridade(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    $('#idprioridade').val(td[0].innerText);
    $('#prioridadeDescricao').val(td[1].innerText);
}

