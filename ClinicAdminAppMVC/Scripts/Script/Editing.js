function Edit(id) {
  
    $('#diagnosis' + id).prop('disabled', false);
    $('#remarks' + id).prop('disabled', false);
}
function Cancel(id) {
    $('#diagnosis' + id).prop('disabled', true);
    $('#remarks' + id).prop('disabled', true);
}

function Update(id) {
    
    //var AppID = $('#ID' + id).text();
    var obj = {
        AppID: $('#ID' + id).text(),
        Diagnosis: $('#diagnosis' + id).val(),
        Remarks: $('#remarks' + id).val(),
    };
    $.ajax({
        
        type: "POST",
        contentType: "application/json",
        url: "/Clinic/Update",
        data: "{AppID:'" + $('#ID' + id).text() + "',Diagnosis:'" + $('#diagnosis' + id).val() + "',Remarks:'" + $('#remarks' + id).val()+"'}",
        dataType: "json",
        success: function (response) {
            console.log("success");
            $('#diagnosis' + id).prop('disabled', true);
            $('#remarks' + id).prop('disabled', true);
            //window.location.href("\Clinic\Appointment");
        },
        failure: function (response) {
            alert(response.responseText);
        },
        error: function (response) {
            alert(response.responseText);
        }
    });


}

