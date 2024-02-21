<script>
    function confirmLogout() {
        if (confirm('Do you really want to sign out?')) {
            // User confirmed logout, redirect to logout route
            window.location.href = '{{ url('logout') }}'; // Use Laravel's route helper
        }
    }
</script>
