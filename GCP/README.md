# Usando la shell de GCP para preparar los recursos de Terraform

1. Creamos una cuenta en GCP
2. Abrimos la shell desde el home de nuestro [GCP](https://console.cloud.google.com)
3. Creamos un proyecto nuevo
    ```
    gcloud projects create <mi-proyecto-nuevo>
    ```
4. Ingresamos al proyecto creado
    ```
    gcloud config set project <mi-proyecto-nuevo>
    ```
5. Creamos nuestra primer Service Account.  
    Podemos crear distintas para cada propósito tanto en dev como prod
    - Creación de los recursos
    - Monitoreo de los recursos
    - Administración de los recursos (eliminación, limpieza, etc)
    ```
    gcloud iam service-accounts create dev-storage-elt \
    --display-name 'almacenamiento de files en dev' \
    --description 'sa solo para entorno de desarrollo para storage'
    ```
6. Creamos un rol personalizado para que nuestra SA pueda crear los recursos necesarios en la nube.
    - Creación de buckets y almacenamiento de files en cloud storage
    - Creación de datasets y tablas en bigquery 
    - Otros…
7. Repetimos con cada SA y los roles específicos para su propósito