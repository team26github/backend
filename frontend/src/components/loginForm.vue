<template>
  <div class="login">
    <h2>LOGIN</h2>
    <form>
      <label for="username">Username:&emsp;</label>
      <input type="text" id="username" name="username" required><br><br>
      <label for="password">Password: &emsp;</label>
      <input type="text" id="password" name="password" required><br><br>
      <input type="submit" id="login-button" value="Login">
    </form>
  </div>
</template>

<script>
export default {
  name: 'login-form'
}
</script>

<style>
.login {
  display: grid;
  place-items: center;
  padding: 0 10px 10px;
  border-style: solid;
  border-color: black;
}

#login-button {
  width: 100%;
}
</style>