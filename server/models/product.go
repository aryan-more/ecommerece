package models

type Product struct {
	Id          int64  `json:"id"`
	Price       int64  `json:"price"`
	Name        string `json:"name"`
	Description string `json:"description"`
	Image       string `json:"image"`
}
