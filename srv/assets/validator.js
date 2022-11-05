class Validator {
    isURL(url) {
        const pattern = new RegExp(/^(?:http(s)?:\/\/)[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$/m);
        return pattern.test(url)
    }
}

const validator = new Validator();

module.exports = { validator }
