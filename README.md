## Overview

Download this repo and continue working on this not finished code base.

Create an additional view written in Swift that lets users create a new Mimo account or lets user login with their existing Mimo account.

- You won't be judged on the visual design at all; the only metric is your code.
- Part of this coding challenge is to read the documentation for the APIs provided to you.
- Use the provided APIs and libraries. If you want to add additional pods, feel free to do so. (Exception: *Lock by Auth0*; remember you should write the authentication code!)
- Use Git to track your changes and upload your Git repo either on [GitHub](https://github.com) or [Bitbucket](https://bitbucket.com) to share it with us.
- Make your first commit, once you start and commit regularly.
- Don't fork this repo. Copy the code into a new folder and start a new project.

All of the authentication is done via [Auth0](https://auth0.com/)

- Auth0 Domain: `mimo-test.auth0.com`
- Auth0 Client ID: `PAn11swGbMAVXVDbSCpnITx5Utsxz1co`
- Auth0 Connection Name: `Username-Password-Authentication`

## Authentication VC

    - The VC should contain two fields: One for the email address and one for the password.
    - If the email doesn't exist upon login, display an error message stating that the account doesn't exist.
    - If the email exists upon signup, display an error message stating that the account already exists.
    - After the login / signup, show the SettingsViewController.
		- Don't use any external library to handle the authentication for you. (Networking libraries like Alamofire are allowed!)

Relevant Auth0 API: [Link_1](https://auth0.com/docs/api/authentication#database-ad-ldap-active-)
[Link_2](https://auth0.com/docs/api/authentication#signup)
Use `openid profile email` for the `scope` parameter

## Additional tasks

    - The existing SettingsViewController should display the email address of the user. Get this info from the JWT that you receive.
    - If the user activates the dark mode (switch in settings), inverse all colors: foreground color should be white, and background color should be black for the entire screen. Use SettingsViewController.swift to make these changes.
    - Save the dark mode state, so it persists if the user closes and reopens the app.
    - Log out should bring you back to the authentication view controller.
    - If you're brave enough, also display the Gravatar picture associated with the email address instead of the default image.
    - If the user isn't logged in or the JWT is expired, show an error message instead of the SettingsViewController.
