set workspace=%1

set mainrepourl=%2

set mainrepobranch=%3

set submoduleurl=%4

set submodulebranch=%5

set submodulename=%6

cd %workspace%

(

IF EXIST %workspace%\submodule rmdir /s /q submodule

mkdir submodule

)

cd %workspace%\submodule

(

                git clone %mainrepourl% .

                git checkout %mainrepobranch%

                git pull origin %mainrepobranch%

                git submodule add -f -b %submodulebranch% %submoduleurl% %submodulename%

                git add .

                git commit -m "Linking Submodule"

                git push origin %mainrepobranch%

                git submodule update --recursive --init

                git submodule foreach git pull origin %submodulebranch%

)