package utils

import (
	"errors"

	"aryan.more/ecom/models"
	"github.com/golang-jwt/jwt/v4"
)

var secret = []byte("Change the secret, it's a place holder")

func GetJWT(id string) (string, error) {
	claims := models.JWTModel{Id: id, RegisteredClaims: jwt.RegisteredClaims{Issuer: "Someone"}}
	token := jwt.NewWithClaims(jwt.SigningMethodHS512, claims)

	return token.SignedString(secret)
}

func GetIdJWT(rawToken string) (string, error) {
	token, err := jwt.ParseWithClaims(rawToken, &models.JWTModel{}, func(t *jwt.Token) (interface{}, error) { return secret, nil })
	if err != nil {
		return "", err
	}

	if claims, ok := token.Claims.(*models.JWTModel); ok && token.Valid {
		return claims.Id, nil

	}
	return "", errors.New("invalid token")
}
