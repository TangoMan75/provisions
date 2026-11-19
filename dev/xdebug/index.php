<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- Disables Internet Explorer compatibility mode (for IE 9 and IE 8 support) -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Sets page scale to 1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Sets content type -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Xdebug</title>
    <!-- Font-awesome 4.7.0 -->
    <!-- https://fontawesome.com/v4.7.0/cheatsheet -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 100vh;
            font-family: sans-serif;
            color: #4d4d4d;
            margin: 0;
        }
        .container {
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }
        @media (min-width: 768px) {
            .container {
                width: 750px;
            }
        }
        @media (min-width: 992px) {
            .container {
                width: 970px;
            }
        }
        @media (min-width: 1200px) {
            .container {
                width: 1170px;
            }
        }

        header {
            width: 100%;
            padding: 1.5em 0;
            border-bottom: 1px solid #dbdbdb;
            background-color: #ededed;
            transition: padding 0.6s ease 0s;
            box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.075);
            margin-bottom: 3em;
        }
        header > nav {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }
        .header__brand {
            color: gray;
            text-shadow: 2px 2px 2px rgba(255, 255, 255, 0.7);
            font-size: 1.3em;
        }
        .header__image {
            border-style: none;
            width: 50px;
            height: 50px;
            vertical-align: middle;
            margin-right: 0.5em;
            border-radius: 50%;
            transition: width 0.6s ease 0s;
        }
        footer {
            width: 100%;
            min-height: 80px;
        }

        a {
            background-color: transparent;
            text-decoration: none;
            color: #337ab7;
        }
        img {
            max-width: 100%;
        }
        ul {
            font-size: 16px;
            line-height: 1.3921875em;
        }
        .fa, .glyphicon {
            font-size: inherit;
        }

        .button {
            display: inline-block;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: .375em .75em;
            line-height: 1.5;
            border-radius: .25em;
            transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
            color: #007bff;
            border-color: #007bff;
            margin-right: .5em!important;
            cursor: pointer;
        }
        .button:hover,
        .button:active {
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .box {
            display: block;
            margin: auto;
            max-width: 683px;
            margin-bottom: 1em;
        }
        .box__header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 1.2em;
        }
        .box__body {
            padding: 0.9em 1.2em;
        }
        .box__body p {
            overflow-wrap: break-word;
        }
        .box__footer {
            padding: 0.9em 1.2em;
        }
        .box {
            border: 1px solid #dbdbdb;
            border-radius: 0.5em;
        }
        .box__header {
            text-align: center;
            border-radius: 0.5em 0.5em 0 0;
            font-size: 1.4em;
            color: #4d4d4d;
        }
        .box__header h1, .box__header h2, .box__header h3, .box__header h4, .box__header h5, .box__header h6 {
            margin: 0.9em;
        }
        .box__body:nth-child(2) {
            /* border top only appears when following header */
            border-top: 1px solid #dbdbdb;
        }
        .box__body ul {
            list-style-type: none;
        }
        .box__footer {
            border-top: 1px solid #dbdbdb;
            border-radius: 0 0 0.5em 0.5em;
            background-color: #ededed;
            font-size: small;
            color: #4d4d4d;
        }

        .footer {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 1.5em 0;
            margin-top: 3em;
        }
        .footer > * {
            /* Footer items margin & padding */
            margin: 1.4em;
            padding: 0.9em;
            width: 291px;
        }
        @media (min-width: 684px) {
            .footer {
                flex-direction: row;
                flex-wrap: wrap;
            }
        }
        .footer {
            border-top: 1px solid #dbdbdb;
            background-color: #ededed;
        }
        .footer > * {
            border-left: 1px solid #dbdbdb;
        }
        .footer p, .footer a {
            color: #4d4d4d;
        }
        .footer ul {
            list-style-type: none;
        }
        .footer .fa {
            margin-right: 1em;
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <a target="_blank" rel="noopener noreferrer nofollow" href="https://tangoman.io" role="menuitem">
                <img class="header__image" src="data:image/jpeg;base64,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" alt="Matthias Morin">
                <span class="header__brand">TangoMan.io</span>
            </a>
            <span></span>
        </nav>
    </header>

    <div class="container">
        <div class="box">
            <div class="box__header">
                <h4>TangoMan Xdebug Configuration Helper</h4>
            </div>
            <div class="box__body">
                <p>
                    <a target="_blank" rel="noopener noreferrer nofollow" href="./php-info.php"><img src="./php.png" alt="PHP logo"></a>
                    <a target="_blank" rel="noopener noreferrer nofollow" href="./xdebug-info.php"><img src="./xdebug.svg" alt="Xdebug logo"></a>
                </p>
                <p>
                    Check your <strong>PHP</strong> configuration is correct with :
                    <a target="_blank" rel="noopener noreferrer nofollow" href="./php-info.php"><span class="fa fa-link"></span>&nbsp;php-info</a>
                </p>
                <p>
                    Enable xdebug in <strong>php.ini</strong> following official documentation here :
                    <a target="_blank" rel="noopener noreferrer nofollow" href="https://xdebug.org/docs/install"><span class="fa fa-link"></span>&nbsp;xdebug documentation</a>
                </p>
                <p>
                    Check Xdebug is correcty configured here :
                    <a target="_blank" rel="noopener noreferrer nofollow" href="./xdebug-info.php"><span class="fa fa-link"></span>&nbsp;xdebug-info</a>
                </p>
                <p>
                    Chrome Xdebug Extension is installable from here :
                    <a target="_blank" rel="noopener noreferrer nofollow" href="https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc"><span class="fa fa-link"></span>&nbsp;Xdebug helper</a>
                </p>
                <p>
                    Enable xdebug in <strong>PHPStorm</strong> following official <strong>JetBrains</strong> documentation here :
                    <a href="https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html"><span class="fa fa-link"></span>&nbsp;jetbrains.com</a>
                </p>

            </div>
            <div class="box__footer"></div>
        </div>

        <div class="box">
            <div class="box__header">
                <h4>php_ini_loaded_file()</h4>
            </div>
            <div class="box__body">
                <p><?php echo(php_ini_loaded_file()); ?></p>
            </div>
            <div class="box__footer"></div>
        </div>

        <div class="box">
            <div class="box__header">
                <h4>php_ini_scanned_files()</h4>
            </div>
            <div class="box__body">
                <p><?php echo(php_ini_scanned_files()); ?></p>
            </div>
            <div class="box__footer"></div>
        </div>

        <div class="box">
            <div class="box__header">
                <h4>PHPStorm Xdebug Configuration</h4>
            </div>
            <div class="box__body">
                <p>
                    <a href="https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html"><span class="fa fa-link"></span> jetbrains.com : Configure Xdebug</a>
                </p>
                <p>
                    <img src="phpstorm_xdebug_config.png" alt="PHPStorm Xdebug Configuration">
                </p>
            </div>
            <div class="box__footer"></div>
        </div>

    </div>

    <footer class="footer" role="contentinfo">
        <p>
            <a href="https://github.com/TangoMan75" target="_blank" rel="noopener noreferrer nofollow">&copy; <?php echo date('Y') ?> Matthias Morin</a>
        </p>
        <p>
            <ul>
            <li><a href="mailto:mat@tangoman.io" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-envelope-square"></span>                   mat@tangoman.io</a></li>
            <li><a href="https://tangoman.io" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-link"></span>                                 tangoman.io</a></li>
            <li><a href="https://github.com/TangoMan75" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-github"></span>                     TangoMan75</a></li>
            <li><a href="https://twitter.com/TangoManParis" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-twitter"></span>                @TangoManParis</a></li>
            <li><a href="https://linkedin.com/in/morinmatthias" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-linkedin"></span>           morinmatthias</a></li>
            <li><a href="https://stackoverflow.com/users/5902933" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-stack-overflow"></span>   tangoman75</a></li>
            <li><a href="https://www.twitch.tv/tangoman75" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-link"></span>                    (twitch) tangoman75</a></li>
            <li><a href="https://www.udemy.com/user/matthias-morin" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-link"></span>           (udemy) matthias-morin</a></li>
            <li><a href="https://openclassrooms.com/fr/membres/matthiasmorin" target="_blank" rel="noopener noreferrer nofollow"><span class="fa fa-link"></span> (openclassrooms) matthiasmorin</a></li>
        </ul>
        </p>
    </footer>

</body>
</html>