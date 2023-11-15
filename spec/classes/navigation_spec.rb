require "rails_helper"

RSpec.describe Navigation do
  describe ".links" do
    it "returns all the links" do
      result = Navigation.links

      expect(result)
        .to(
          eq(
            [
              Navigation::Link.new(path: "/about", text: "About"),
              Navigation::Link.new(
                path: "/projects",
                text: "Projects",
                attrs: {class: :active, aria: {current: true}}
              ),
              Navigation::Link.new(path: "/music", text: "Music")
            ]
          )
        )
    end

    context("when passed a path") do
      it "returns all the links with current class" do
        result = Navigation.links("/about")

        expect(result)
          .to(
            eq(
              [
                Navigation::Link.new(
                  path: "/about",
                  text: "About",
                  attrs: {class: :active, aria: {current: true}}
                ),
                Navigation::Link.new(path: "/projects", text: "Projects"),
                Navigation::Link.new(path: "/music", text: "Music")
              ]
            )
          )
      end
    end

    context("when passed an unparseable path") do
      it "returns the links with projects active" do
        result = Navigation.links("asdf")

        expect(result)
          .to(
            eq(
              [
                Navigation::Link.new(path: "/about", text: "About"),
                Navigation::Link.new(
                  path: "/projects",
                  text: "Projects",
                  attrs: {class: :active, aria: {current: true}}
                ),
                Navigation::Link.new(path: "/music", text: "Music")
              ]
            )
          )
      end
    end
  end
end
