Option Strict On
Option Explicit On
'Austin Duda Question 3 Homework 4
Module Module1

    Sub Main()

        Console.WriteLine("Enter Number of Shirts Bought ")
        Dim shirts As Integer
        Dim price, tax, salestax, total As Double
        Dim salestring, totalstring, pricestring As String

        tax = 1.06
        shirts = CInt(Console.ReadLine())

        If (shirts < 4) Then
            price = 15.75
        ElseIf (shirts >= 4 And shirts <= 10) Then
            price = 12.5
        ElseIf (shirts > 10) Then
            price = 8
        End If

        total = (price * shirts) * tax
        salestax = total - (price * shirts)
        salestring = FormatCurrency(salestax, 2)
        pricestring = FormatCurrency(price, 2)
        totalstring = FormatCurrency(total, 2)

        Console.Write("Shirts Sold ")
        Console.WriteLine(shirts)

        Console.Write("Total Price ")
        Console.WriteLine(totalstring)

        Console.Write("Total Sales Tax ")
        Console.WriteLine(salestring)

        Console.Write("Price Per Shirt ")
        Console.WriteLine(pricestring)

        Console.Read()

        'Enter Number of Shirts Bought
        '12
        'shirts Sold 12
        'total price $101.76
        'total Sales Tax $5.76
        'price Per Shirt $8.00



    End Sub

End Module
