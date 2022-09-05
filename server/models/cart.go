package models

type CartUpdateBody struct {
	Products []CartItem `json:"products"`
}

type CartItem struct {
	ProductId int `json:"productid"`
	Quantity  int `json:"quantity"`
}
