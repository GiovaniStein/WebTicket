$(document).ready(function () {
    $('#cadastraCidade').click(function (event) {
        event.preventDefault();
        if (valida_form_cidade() === true) {
            $.ajax({
                type: "POST",
                url: "/WebTicket/acao?parametro=cadCidade",
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Houve um erro!", resultado, "error");
                } else {
                    swal("Sucesso ao Salvar!", "", "success");
                    $('#formCidade').each(function () {
                        this.reset();
                    });
                    $("#listadeCidades").load("listaCidades.jsp");
                }
            });
            return false;
        } else {
            swal("Preencha os campos corretamente!");
        }
    }
    );
});

function valida_form_cidade() {
    if ((document.getElementById("idDescricao").value === null || document.getElementById("idDescricao").value === "")) {
        return false;
    } else {
        return true;
    }
}

function editCity(element) {
    var element = $(element);
    var row = element.parent().parent();
    var td = row[0].children;
    $('#idCidade').val(td[0].innerText);
    $('#idDescricao').val(td[1].innerText);
}

function removeCity(element) {
    var value = $(element).val();
    swal({
        title: 'Cuidado!',
        text: "Tem certeza que deseja remover essa cidade?",
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
                url: '/WebTicket/acao?parametro=exCidade&id=' + value,
                data: $('form').serialize()
            }).done(function (retorno) {
                var resultado = $.trim(retorno);
                if (resultado !== "ok") {
                    swal("Erro ao remover cidade!", resultado, "error");
                } else {
                    swal("Cidade removida com sucesso!", "", "success");
                    $("#listadeCidades").load("listaCidades.jsp");
                }
            });
            return false;
        }
    });
}