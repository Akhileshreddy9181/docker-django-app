#Stage1

FROM ubuntu as build
WORKDIR /app

COPY requirements.txt /app
COPY devops /app

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip install -r requirements.txt


# In Stage1 , we are creating a app dir and copying code from local to image and installing all the required dependencies
#In Stages2 , i just have to execute the python application, i dont need the ubuntu image, which is heavier than the python distro image.


#Stage2

FROM python

WORKDIR /app
COPY --from=build /app /app

ENV PATH="/app:${PATH}"

ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
