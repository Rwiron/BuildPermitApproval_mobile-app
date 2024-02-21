@if (!empty(session('success')))
<div class="alert alert-success" role="alert" id="successAlert">
    {{ session('success') }}
</div>
<script>
    setTimeout(function() {
        document.getElementById('successAlert').style.display = 'none';
    }, 2000); //  The message iraza kuvamo nyuma  ya  5 seconds
</script>
@endif

@if (!empty(session('error')))
<div class="alert alert-danger" role="alert" id="errorAlert">
    {{ session('error') }}
</div>
<script>
    setTimeout(function() {
        document.getElementById('errorAlert').style.display = 'none';
    }, 2000); // The message iraza kuvamo nyuma  ya  5 seconds
</script>
@endif

