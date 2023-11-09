find . -type f \( -not -name "*.sh" -and -not -path "./.git/*" -and -not -path "./policies/*" -and -not -path "./test/*" \) -exec rm {} \;

# for script in $(ls -1v [0-9]*.sh); do
#     bash "$script"
# done

bash "02-run-minikube.sh"
bash "03-install-cert-manager.sh"
bash "04-install-opa.sh"
bash "06-test-validation.sh"
bash "07-test-mutation.sh"