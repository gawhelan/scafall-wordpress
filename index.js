module.exports = {
    staticFiles: [
        {cwd: 'content', src: 'Vagrantfile'},
        {cwd: 'content', src: 'gitignore', dest: '.gitignore'},
        {cwd: 'content', src: 'vm-config'},
        {cwd: 'content', src: 'website'},
    ],
    templateFiles: [
        {cwd: 'content', src: 'Vagrantfile'},
        {cwd: 'content', src: 'vm-config/provision.sh'},
        {cwd: 'content', src: 'website/wp-config.php'},
    ],
    scripts: {
        'post-init': 'post-init.sh',
    },
    questions: [{
        type: 'input',
        name: 'wpVersion',
        message: 'Which version of WordPress',
        default: '4.1.1',
        validate: function (value) {
            return !!value.match(/^\d+\.\d+(?:\.\d+)?$/) ||
                'Please enter a valid version number';
        }
    },{
        type: 'confirm',
        name: 'customizeWp',
        message: 'Customize the WordPress settings',
        default: false,
    },{
        type: 'input',
        name: 'wpDbName',
        message: 'What should the WordPress database be called',
        default: 'wordpress',
        when: function (answers) {return answers.customizeWp;}
    },{
        type: 'input',
        name: 'wpDbUser',
        message: 'What should the database username be',
        default: 'wordpress',
        when: function (answers) {return answers.customizeWp;}
    },{
        type: 'input',
        name: 'wpDbPassword',
        message: 'What should the database password be',
        default: 'password',
        when: function (answers) {return answers.customizeWp;}
    },{
        type: 'confirm',
        name: 'customizeVm',
        message: 'Customize the VM settings',
        default: false
    },{
        type: 'input',
        name: 'vmPortForward80',
        message: 'Forward port 80 to',
        default: '8000',
        validate: function (value) {
            return !!value.match(/^\d+$/) ||
                'Please enter a valid port number';
        },
        when: function (answers) {return answers.customizeVm;}
    },{
        type: 'input',
        name: 'vmPrivateIp',
        message: 'What private IP should the VM use',
        default: '192.168.2.99',
        validate: function (value) {
            return !!value.match(/^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/) ||
                'Please enter a valid IP address';
        },
        when: function (answers) {return answers.customizeVm;}
    }]
};
