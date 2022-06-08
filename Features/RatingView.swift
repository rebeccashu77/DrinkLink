//
//  RatingView.swift
//  DrinkLink
//
//  Created by Yuna Kim on 4/10/22.
//  Copied this code from a git project!
// https://github.com/twostraws/HackingWithSwift/blob/main/SwiftUI/project11/Bookworm/RatingView.swift

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var label = ""
    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color(hue: 0.1639, saturation: 1, brightness: 1)

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }

    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}
