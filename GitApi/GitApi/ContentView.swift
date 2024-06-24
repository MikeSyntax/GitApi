//
//  ContentView.swift
//  GitApi
//
//  Created by Mike Reichenbach on 24.06.24.
//

import SwiftUI

struct ContentView: View {

    @State private var user: GitHubUser?
    @StateObject var repo = Repoository()
    @State private var name: String = ""
    @FocusState private var isActive: Bool
    var body: some View {
        VStack(spacing: 20) {

            AsyncImage(
                url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .foregroundColor(.secondary)
                }
                .frame(width: 120, height: 120)
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))

            Text(user?.login ?? "User Placeholder")
                .bold()
                .font(.title3)
                .padding()

            Text(user?.bio ?? "Bio placeholder")
                .padding()
            Spacer()
            HStack{
                ZStack(alignment: .trailing){
                    TextField("Enter name!", text: $repo.name)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .shadow(radius: 3)
                        .focused($isActive)
                    Button(){
                        repo.name = ""
                    }label: {
                        Image(systemName: "trash")
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                    }
                    .offset(x: -18, y: 0)
                }
                Button{
                    Task {
                        await loadUser()
                    }
                    isActive = false
                } label: {
                    Text("Enter")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .task {
            await loadUser()
        }
    }
    func loadUser() async {
        do {
            user = try await repo.getUser()
        } catch GitError.invalidURL {
            print("invalid url")
        } catch GitError.invalidResponse {
            print("invalid response")
        } catch GitError.invalidData {
            print("invalid data")
        } catch {
            print("unexpected Error")
        }
    }
}

#Preview {
    ContentView()
}


