//
//  TextFieldWithLabel.swift
//  DrinkLink
//
//  Created by Yuna Kim on 3/29/22.
//

import SwiftUI

enum TextFieldValidationStatus {
  case valid
  case invalid
  case silent
}

struct TextFieldWithLabel: View {
  var label: String
  var placeholder : String?
  var hint: String?
  @Binding var text: String

  var validationStatus: Binding<Bool>?
  var validationMessage: String?

  var body: some View {
    VStack(alignment: .leading, spacing: 3.0) {
      HStack {
        Text(label).font(.caption).bold()
        Spacer()
        if let hint = hint {
          Text(hint).font(.caption2)
        }
      }
      TextField(placeholder ?? "", text: $text)
        .padding()
         .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(
          self.validationStatus?.wrappedValue == false ? Color.red :
          Color.black, style: StrokeStyle(lineWidth: 1.0)))
         .padding()
      if let validationMessage = validationMessage, validationStatus?.wrappedValue == false {
        Text(validationMessage).foregroundColor(.red).font(.caption)
      }
    }
  }
}

struct TextFieldWithLabel_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldWithLabel(label: "Text Label", placeholder: "Placeholder", hint: "This is a hint.", text: Binding.constant("CS290.02"))
      .padding(10)
  }
}

