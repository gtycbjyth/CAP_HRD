const constants = require('./constants');

const checkAssessmentPeriod = (date) => {
    const dateNow = new Date();
    if ((date.getMonth() - dateNow.getMonth()) >= constants.assessmentPeriod) {
        if (date.getDate() <= dateNow.getDate()) {
            return true;
        }
        return false;
    }
}

module.exports = { checkAssessmentPeriod };