World of Sheldor - README file <br/>
<br/>
Contributors:<br/>
Robi Tacutu (robi.tacutu@gmail.com)<br/>
Bogdan Dinu (bogdan.dinu@gmail.com)<br/>
<br/>
<br/>
Useful Information:<br/>
<br/>

1. Instaling Git <br/>
http://www.railstutorial.org/book#sec:git_setup<br/>

OR<br/>

git config --global user.name "Your Name"<br/>
git config --global user.email youremail@example.com<br/>

... and checkout project from my GitHub repository:
1.1. In the Git GUI, create repository with the project directory (empty project)<br/>
1.2. Setting GitHub (auth keys and repository in Git) <br/>
In Git GUI, Help > Show SSH key (that is the public key). If there is no key, you can generate one. This public key must be put in GitHub (administrative panel). Note: I think the key uses the e-mail set in Git. <br/>   
1.3. Then Remote>Add, name=github, location=git@github.com:LightSoul/World-of-Sheldor.git<br/>
1.4. Remote > Fech From > github


3. Deployment on Heroku<br/>
3.1. Install => gem install heroku <br/>
3.2. Adding SSH keys (previously created for Git) => heroku keys:add <br/>
3.3. Pushing a site version => git push heroku <branch_name> <br/>
(this can be also done from GitGUI) <br/>
3.4. Migrating the database => heroku rake db:migrate <br/> 