package models

import "github.com/golang-jwt/jwt/v4"

type JWTModel struct {
	Id string `json:"id"`
	jwt.RegisteredClaims
}
