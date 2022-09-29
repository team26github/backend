export default {
    template: `
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
    `,

    data () {
        return {
            processing: true
        };
    }
}